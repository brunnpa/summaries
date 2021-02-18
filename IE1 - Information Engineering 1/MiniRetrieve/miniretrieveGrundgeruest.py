#!/usr/bin/python
# coding=iso-8859-1

# re = Regex https://docs.python.org/3/library/re.html
import sys, os, os.path, re, collections, math, operator

# Kleiner "Trick", damit wir die Datenstrukturen dynamisch aufbauen können

invindex = collections.defaultdict(lambda: collections.defaultdict(int))
noninvindex = collections.defaultdict(lambda: collections.defaultdict(int))
queries = collections.defaultdict(lambda: collections.defaultdict(int))

indir = os.path.dirname(os.path.realpath(__file__)) + '/documents/'

# Alle Filenamen lesen

files = [ file for file in os.listdir(indir) if os.path.isfile(os.path.join(indir,file)) ]

# Anzahl Dokumente (brauchen wir für idf-Berechnung u.ae.)

numdocs = len(files)

# Schleife über alle Textdateien

for file in files:
	sys.stderr.write("INDEXING: " + file + "\n")
	sys.stderr.flush()

# Textdatei lesen

	with open(os.path.join(indir,file), 'r') as infile:
		doc = infile.read()

# Textdatei tokenisieren -> Tokenisierung ist der Prozess, der die einzelnen Wörter aus dem Text extrahiert
# text wird in einzelne Wörter gesplittet und anschliessend als 'lower' abgespeichert -> Gross/Kleinschreibung
	for term in re.split(r'\W', doc):
		term = term.lower()

# Datenstrukturen aufbauen
# Gemaess Pseudocode

		invindex[term][file] += 1 #increment frequency in inverted index
		noninvindex[file][term] += 1 #increment frequency in non-inverted index


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

querydir = os.path.dirname(os.path.realpath(__file__)) + '/queries/'

files = [ file for file in os.listdir(querydir) if os.path.isfile(os.path.join(querydir,file)) ]

for file in files:

# Querydatei lesen

	with open(os.path.join(querydir,file), 'r') as infile:
		text = infile.read()

# Tokenisieren...

	for term in re.split(r'\W', text):
		term = term.lower()

# Datenstruktur für Queries bauen

		if len(term):
			queries[file][term] += 1

# Wir sortieren die Queries vor dem Processing..

queryids = queries.keys()
queryids = sorted(queryids)
#queryids.sort(key=int)

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


	for rankcounter in range(min(10, len(results))):
		print("{0} Q0 {1} {2} {3} miniRetrieve".format(query, results[rankcounter][0], rankcounter, results[rankcounter][1]))
