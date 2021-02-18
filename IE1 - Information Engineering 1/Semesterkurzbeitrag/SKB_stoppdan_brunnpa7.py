#!/usr/bin/python
# coding=iso-8859-1

import sys, os, os.path, re, collections, math, operator
import xml.etree.ElementTree as ElementTree
from PyDictionary import PyDictionary  # pip install PyDictionary ausführen
import nltk
from nltk.corpus import wordnet, stopwords

nltk.download('wordnet')
nltk.download('stopwords')

# Kleiner "Trick", damit wir die Datenstrukturen dynamisch aufbauen können

invindex = collections.defaultdict(lambda: collections.defaultdict(int))
noninvindex = collections.defaultdict(lambda: collections.defaultdict(int))
queries = collections.defaultdict(lambda: collections.defaultdict(int))
dictionary = PyDictionary()
stop_words = set(stopwords.words('english'))

run_type = 'both'  # both, docs, query, initial
number_of_results = 1000

# Alle Dokumente lesen

with open(os.path.dirname(os.path.realpath(__file__)) + '/documents/irg_collection.trec', 'r') as f:
	xml = f.read()

documents = ElementTree.fromstring(xml)
numdocs = len(documents)
doc_counter = 0
synonym_counter_doc = 0
word_counter_doc = 0


# Simple loop through each document
for doc in documents:

	doc_counter += 1
	if doc_counter %5 == 0:
		print("DocumentCounter/NumDocs: {0} / {1}\n".format(doc_counter, numdocs))

	file = doc.find('recordId').text
	words = re.split(r'\W', doc.find('text').text)
	filtered_words = [w for w in words if not w in stop_words]

	word_counter_doc += len(filtered_words)

	for term in filtered_words:
		term = term.lower()
		invindex[term][file] += 1 #increment frequency in inverted index
		noninvindex[file][term] += 1 #increment frequency in non-inverted index

		if run_type == 'both' or run_type == 'docs':
			# ToDo: Eigenleistung
			synonyms = []
			syn = wordnet.synsets(term, pos=wordnet.NOUN)
			if not len(syn):
				continue
			syn = syn[0]

			#for syn in wordnet.synsets(term + '.n.01'):
			for lm in syn.lemmas()[:2]:
				synonym_counter_doc += 1
				term_synonym = lm.name().lower()
				invindex[term_synonym][file] += 1  # increment frequency in inverted index
				noninvindex[file][term_synonym] += 1  # increment frequency in non-inverted index

# Hier sind die Dokumente fertig indexiert... Wir bauen jetzt die Normalisers und Idfs

dnorm = {}
idf = {}

# Pro File:

for file in noninvindex.keys():
	dnorm[file] = 0.0

# Pro Wort: berechne Idf, summiere dnorm auf

	for word in noninvindex[file].keys():
		documentfreq = len(invindex[word])
		idf[word] = math.log10((1.0 + numdocs)/(1.0 + documentfreq))
		a = noninvindex[file][word] * idf[word]
		dnorm[file] += ( a * a )

	dnorm[file] = math.sqrt( dnorm[file] )

# Lese die Queries

with open(os.path.dirname(os.path.realpath(__file__)) + '/queries/irg_queries.trec', 'r') as f:
	xml = f.read()

query_records = ElementTree.fromstring(xml)

numquery = len(query_records)
synonym_counter_query = 0
word_counter_query = 0


# Simple loop through each document
for query in query_records:
	# print(
	# 	'recordId: {}, text: {}'.format(
	# 		query.find('recordId').text.strip(),
	# 		query.find('text').text.strip(),
	# 	)
	# )
	queryId = query.find('recordId').text

	all_queries = re.split(r'\W', query.find('text').text)
	filtered_queries = [w for w in all_queries if not w in stop_words]

	word_counter_query += len(filtered_queries)

	for term in filtered_queries:
		term = term.lower()

# Datenstruktur für Queries bauen

		if len(term):
				queries[queryId][term] += 1

				if run_type == 'both' or run_type == 'query':
					# ToDo: Eigenleistung
					synonyms = []
					for syn in wordnet.synsets(term, pos=wordnet.NOUN):
						for lm in syn.lemmas():
							synonym_counter_query += 1
							queries[queryId][lm.name()] += 1






# Wir sortieren die Queries vor dem Processing..

queryids = queries.keys()
queryids = sorted(queryids)

# Pro Query:

for query in queryids:
	sys.stderr.write("QUERY: " + query + "\n")
	sys.stderr.flush()
# Querynorm zurückstellen, Akku initialisieren
	qnorm = 0.0
	accu = {}
# pro Queryterm:
	for word in queries[query].keys():
# Spezialfall: Queryterm kommt in KEINEM Dokument vor. Hat auf Ranking keinen Einfluss, aber ändert die absoluten Scores
		if word not in idf:
			idf[word] = math.log10( 1.0 + numdocs )
# Gewicht Queryterm, aufsummieren Qnorm
		b = queries[query][word] * idf[word]
		qnorm += b * b
# Queryterm nachschlagen
		if word in invindex:
			for document in invindex[word].keys():
# Gewicht Queryterm in Dokument
				a = invindex[word][document] * idf[word]
# Fall abwenden, ansonsten kommt ein Fehler beim berechnen
				if document not in accu:
					accu[document] = 0.0

# Akku aufdatieren
				accu[document] += (a * b)
	qnorm = math.sqrt(qnorm)
# Akkus normalisieren
	for entry in accu.keys():
		accu[entry] = accu[entry]*1000
		accu[entry] /= (dnorm[entry] * qnorm)

# Rangliste sortieren

	results = sorted(accu.items(), key=operator.itemgetter(1), reverse=True)

# Ausgabe Resultate

	if run_type == 'initial':
		f = open("initialResult.txt", "a+")  #Ausgangslage

	if run_type == 'query':
		f = open("playingAroundWithSynonymsForQueries.txt", "a+")

	if run_type == 'docs':
		f = open("playingAroundWithSynonymsForDocs.txt", "a+")

	if run_type == 'both':
		f = open("playingAroundWithSynonymsForBoth.txt", "a+")



	for rankcounter in range(min(number_of_results, len(results))):
		f.write("{0} Q0 {1} {2} {3} stoppdanBrunnpa7 \n".format(query, results[rankcounter][0], rankcounter, results[rankcounter][1]))

	f.close()


print("average wordnumber in Doc: {0}\n".format(word_counter_doc/numdocs))
print("average added synonym in Doc: {0}\n".format(synonym_counter_doc/numdocs))
print("average wordnumber in query: {0}\n".format(word_counter_query/numquery))
print("average added synonym in query: {0}\n".format(synonym_counter_query/numquery))


#ToDo:
# - Wortarten Erkennung -> Evtl ausblenden
# - Synonym Erkennung https://pypi.org/project/PyDictionary/#:~:text=PyDictionary%20is%20a%20Dictionary%20Module,for%20getting%20synonyms%20and%20antonyms.
# - - Synonyme in Query, Dokument und beidem hinzufügen
# - Wo werden die Synonyme angebunden -> Dokument (Vermutung, verfälscht Ergebnis) oder Query