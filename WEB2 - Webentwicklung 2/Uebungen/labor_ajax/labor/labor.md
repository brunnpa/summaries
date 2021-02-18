# Veranstaltungseinheit Ajax Grundlagen

## JSON abrufen und verwerten

### Ziel der Übung

* Sie verstehen die Prinzipien des XHR
* Sie können mit Hilfe der jQuery Library einfache AJAX Requests
  absetzen
* Sie können ein Resultat im JSON Format verwerten
* Sie kennen eine Möglichkeit Dritt-Systeme in Testfällen zu simulieren

### Aufgabe(n)

Die Pendenzenlisten sollen neu von einem Webserver geladen werden. 

Der Server zhaw.herokuapp.com stellt einen einfachen Dienst zum Laden von
Pendenzenlisten zur Verfügung. Von der URL
http://zhaw.herokuapp.com/task\_lists/`:id` kann eine Pendenzenliste im JSON
Format geladen werden. `:id` ist dabei zu ersetzen, mit einer
Identifizierung einer auf dem Server bekannten Liste. Für diese Aufgabe
kann die Liste mit der Identifizierung `demo` verwendet werden: 

http://zhaw.herokuapp.com/task\_lists/demo

(Achtung bei copy & paste, task\_lists ist mit einem underscore
geschrieben)

Ergänzen sie den abgegebenen Code um folgendes Verhalten:

* Die Methode `load` in der Datei `src/TaskList.js` ist zu
  implementieren. Diese hat den Zweck, eine Tasklist-Instanz vom Server zu
  laden.
* `spec/TaskListSpec.js` enthält einen Test zum Laden der 
  Pendenzenliste vom Server. Dieser Test soll funktionieren.
  Implementieren sie dazu in der Datei `src/TaskList.js` die
  vorbereitete Methode `load`
* Beachten sie die Kommentare zur Methode, insb. zu den übergebenen
  Parametern
* Benutzen Sie am besten die jQuery Methode `$.getJSON` um den AJAX
  Request zu machen. Konsultieren Sie zur genauen Funktionsweise dieser
  Methode die jQuery API Dokumentation.
* Beachten Sie, dass der Bootstrap Code in `src/Demo.js` bereits darauf
  ausgerichtet ist, die Taskliste demo über das entsprechende API zu
  laden.

### Erwartete Resultate und Abgabe

* Funktionsfähige Website inkl. Testsuite gemäss der Aufgabenstellung
* Beantwortung folgender Fragen (mündlich oder in Stichworten):
    * Wozu dient der Paramter `callback` der Methode `load`?
    * Wäre eine Implementierung auch ohne diesen Parameter möglich?
    * Wenn Sie anstelle von `$.getJSON` die generische Methode `$.ajax`
      benutzen würden müssten, müssten sie welche zusätzlichen
      Konfigurationsparameter mitgeben?
* Bei Erfüllung analoger Kriterien kann das Resultat auch in ihr Projekt
  aus der Projektschiene integriert werden.

* Abgabe während dem Labor.

