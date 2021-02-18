#!/bin/sh

# Fach:			PROGC
# Praktikum:	Praktikum 1 des C-Teils, Aufgabe 3
# Beschreibung:	Dieses Shell-Script testet das C-Programm wortzaehler (Zeichen und Wörter zählen).
# Abhängigkeiten: Es wird ein Input File (input.data) mit Testdaten sowie ein File mit den entsprechenden Ausgaben (output_correct.data) benötigt.
#

# Dateiname des Input-Files, jede Zeile gilt als eine Eingabe.
input_file="input.data"

# Dateiname des Outputfiles (wird generiert)
output_file="output.data"

# Dateiname des Files mit den korrekten Ausgaben (Musterlösungen) abhängig vom $input_file.
correct_output_file="output_correct.data"

# Jede Zeile im Input-File wird einzeln gelesen und dem C-Programm (wortzaehler) übergeben. Die Ausgabe wird in einer temp. Datei gespeichert.
while read line
do
	echo $line | ./wortzaehler
done < $input_file > output.tmp

# Der gesamte STDOUT wurde nun im temp. File gespeichert (inkl. printf(...) ). Da man nur das Resultat möchte, muss der Rest extrahiert werden.
# Mitels cut kann der Text spaltenweise extrahiert werden (z.B. cut -d " " -f 6 < output.tmp > $output_file).
# Folgend wird sed verwendet. Mit diesem Befehl kann ein bestimmtes Textmuster manipuliert (in unserem Falle gelöscht) werden.
sed -i 's/Geben Sie einen Satz ein: Eingegeben: //g' output.tmp
cat output.tmp > $output_file

# Löschen von Temp-File
rm output.tmp

# $output_file (ist) wird mit $correct_output_file (soll) verglichen. Falls es Unterschiede gibt, werden diese aufgelistet.
diff -u -s $output_file $correct_output_file
