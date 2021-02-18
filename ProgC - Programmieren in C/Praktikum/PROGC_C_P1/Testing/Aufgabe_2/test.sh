#!/bin/sh

# Fach:			PROGC
# Praktikum:	Praktikum 1 des C-Teils, Aufgabe 2
# Beschreibung:	Dieses Shell-Script testet das C-Programm converter (Fahrenheit nach Celsius umrechnen).
# Abhängigkeiten: Es wird ein File (output_correct.data) benötigt, welches den korrekten Output beinhaltet (Musterlösung).
#

# Dateiname des Outputfiles (wird generiert)
output_file="output.data"

# Dateiname des Files mit den korrekten Ausgaben (Musterlösungen) abhängig vom $input_file.
correct_output_file="output_correct.data"
 
# Jede Zeile im Input-File wird einzeln gelesen und dem C-Programm übergeben. Die Ausgabe wird in $output_file gespeichert
./converter > $output_file

# $output_file (ist) wird mit $correct_output_file (soll) verglichen. Unterschiede werden auf dem Bildschirm ausgegeben.
diff -u -s $output_file $correct_output_file
