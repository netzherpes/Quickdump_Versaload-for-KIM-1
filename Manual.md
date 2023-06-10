Around the center of the utilities Superdump and Superload the editor (Rohland Löhr) build a progressive framework:<br>
VERSALOAD is not only a loading routine, but also a Copy program, a directorry program, a header search, and a linking / relocating program. 
The last property is the most handy one. 
VERSALOAD uses the service from issue 1 of Mikromag called RELOAD. Program segments will be loaded from the next free Memoryarea and translated to a new adress area. (please take a look at issue 1)<br>
Another nice feature is the possible restricted input buffer, A memory area can be protected against unwanted overwriting with setting so in 17F8 /F9. 

Programs can be loaded with the standard 1 Byte ID  od a a 6 byte label. Versaload recognizes the pattern of identification and is looking for identities. It also recognizes, if there are othe Options for writing external parameters or reserved memory (up to 256 bytes). 

Quickdump and Versaload are written as subroutines. Just jsr entry with the Parameters in A and X. 
This pair of programsis inkompatible with other saving and loading routines. It will give you a set of tools that are similar to data handling on larger Computers.

# Quickdump


Writiing to tape with 1-Byte-ID:<br>
Startadress    SAL/SAH to 17F5/F6<br>
Endadresse+1    EAL/EAH to 17F7/F8<br>
Identity       ID    to 17F9<br>
Start           STARTADRESSE is $0600<br>

Writing to tape with a 6-Byte-Name: <br>
Startadress and Endadresse like before<br>
Identity      Header to 1780-1785 or change LOSWI to another area<br>
Start          STARTADRESSE is $0605<br>

Writing to tape with additional parameters: <br>
Startadress, Endadress und header like before.<br>
LDA of the length of the table stored in 1780. <br>
LDX #$ 00<br>
JSR ENTRY1<br>





Um das Herzstück der utilities SUPERDUMP und SUPERLOAD baute der 
Herausgeber einen Rahmen, der sicher fortschrittlich ist:
VERSALOAD ist nicht nur ein reines Ladeprogramm, sondern zugleich auch 
Kopierprogramm (wie SUPER DUPE), Inhaltsverzeichnis (wie DIRECTORY), 
Etikettensucher (wie HEADHUNTER des Herausgebers) und es ist neben 
anderem auch ein linking and/or relocating program loader.
Diese Eigenschaft dürfte die schönste und bequemste von allen sein. 
VERSALOAD nutzt die Dienste des in Heft 1 des 65xx MICRO MAG abgedruckte 
RALOAD (Verschiebung und Umrechnung): Programmsegmente werden jeweils ab 
nächstfolgender freier Speicherzelle geladen und für den neuen Adressenraum umgerechnet (zur notwendigen 'Syntax' s. Heft 1).
Nützlich ist auch die mögliche Festlegung eines Eingabepuffers. 
Ein Speicherbereich kann ab einer in Loc. 17F7/F8 festgelegten
Anfangsadresse gegen unbeabsichtigtes Oberschreiben durch das einzu- 
lesende Programm geschützt werden.
Programme oder Datensätze können wahlweise mit 1-Byte-ID oder mit 
einem Standard-Label (Name von 6 Bytes) versehen sein. VERSALOAD
erkennt die gewählte Form der Identifizierung und sucht entsprechend nac 
Gleichheit. Es erkennt auch, ob ein Bandsatz darüber hinaus zusätzliche 
Bytes (bis 249) als Option mit sich führt, um z.B. Namen und Speicherplatz benötigter oder abzugebender 'externer Parameter' zu beschreiben.
QUICKDUMP und VERSALOAD sind als Unterprogramme geschrieben. Sie 
ermöglichen kontinuierliches, von der Maschine her gesteuertes Arbeiten 
(JSR ENTRY mit Paramtern in A bzw. in X). Bei Aufruf mit einer der 
Kopfzeilen kann jedoch ebenso einmaliges Abarbeiten mit Rückkehr zum 
KIM-Monitor bewirkt werden. Das Datenformat beim Schreiben und
das Blockdiagramm des Leseprogrammes sind auf den folgenden Seiten 
abgedruckt.

Dieses Programm-Paar ist mit anderen Aufzeichungsformen nicht kompatibel
In der Summe haben wir jetzt Dienstleistungen zur Hand, die schon 
denen einer größeren Datenverarbeitung ähneln. Insbesondere sei auch 
auf Möglichkeiten des Overlay hingewiesen: Bei begrenztem Speicher 
können lange Programme in Segmente zerlegt werden, die bei Bedarf
in einen Puffer (Overlaybereich) nachgezogen werden.

# Quickdump

Weitere Hinweise zu QUICKDUMP

Schreiben eines Bandes mit 1-Byte-ID:<br>
Startadresse    SAL/SAH nach 17F5/F6<br>
Endadresse+1    EAL/EAH nach 17F7/F8<br>
Identität       ID    nach 17F9<br>
Start           STARTADRESSE in $0600<br>

Schreiben eines Bandes mit 6-Byte-Namen (Standard header): <br>
Startadresse und Endadresse wie vor<br>
Identität      Header nach 1780-1785 oder bei Veränderung der Adresse in LOSWI woanders.<br>
Start          STARTADRESSE in $0605<br>

Schreiben eines Bandes zusätzlich mit 'externen Parametern': <br>
Startadresse, Endadresse und standard header wie vor.<br>
LDA wirkliche Länge der in 1780 ... gespeicherten Tabelle. <br>
LDX #$ 00<br>
JSR ENTRY1<br>

# VERSALOAD

Wie schon dargestellt, bietet VERSALOAD 6 grundsätzliche Dienstleis- 
tungen (Blockdiagramm auf der nächsten Seite). Welche im einzelnen 
ausgeführt wird, hängt vom gewählten Startpunkt ab oder von dem im 
Akkumulator mitgebrachten Parameter, wenn man JSR ENTRY aufruft.
Diese sechs Dienstleistungen werden durch die Buffer-Möglichkeit 
ergänzt: SAL/SAH in 17F5/F6 legen dann eine Anfangsadresse für das 
Speichern fest, EAL/EAH in 17F7/F8 das Buffer-Ende+1 (erste zu schüt- 
zende Zelle). Wenn ein Ladevorgang wegen Erreichens des Schutzbereiches 
unvollständig abgebrochen werden mußte, so erfolgt Fehleranzeige
durch den KIM-Monitor mit 'FFFF1CI, zugleich wird die LFLAG auf 'FF' 
gesetzt. Lesefehler mit abweichender Checksum führen zur gleichen 
Monitor-Anzeige, die LFLAG wird aber auf 'FE' gesetzt.
Die Zahl der Dienstleistungen wird eigentlich fast verdreifacht, weil
die Identitätsangabe für die zu lesenden Bandsätze verschieden sein darf:

  a) Identität 1 Byte, Vergleich mit Zelle 17F9,<br>
  b) Standard-Name 6 Bytes, Vergleich mit Tabelle in 1780-85,<br>
  c) Standard-Name wie in b), zusätzlich externe Parameter, die beim Lesen in den Zellen 1786 ff. abgelegt werden.

Die Dienstleistungen im einzelnen:
LADOE, LOAD Open End. Ein Programm wird an seinem alten Speicherplatz geladen, es darf beliebig lang sein, weil ein Puffer nicht zu 
beachten ist.

LOADBU, LOAD only up to end of BUffer. Einspeicherung ab altem Speicherplatz aber nicht über Puffer-Ende hinaus.
DATALB, DATA Load to Buffer. Anfang und höchstmöglicher Speicherplatz sind festgelegt.
RELOE, RELocate Open End. Rechnet ein Programm sofort nach dem Laden ab festgelegter Speicheradresse auf den neuen Adressenbereich um, und zwar mit Hilfe des in Heft 1 von 65xx MICRO MAG beschriebenen RALOAD, 
das natürlich im Speicher resident sein muß. Ein Pufferende muß
nicht berücksichtigt werden.

RELBUF, RELocate with BUffer. Wie vor, die Endadresse darf nicht 
überschritten werden.

LINKOE, LINK Open End. Verwirklicht Laden und Verschweißen. Laden ab 
der in VEB+1, 2 ausgewiesenen.ersten freien Speicherstelle und 
Umrechnen mit RALOAD auf den neuen Adressenbereich.

LINKBU, LINK with BUffer. Entspr. LINKOE bzw. RELBUF.

DUPE entspricht den Funktionen von Jim Butterfields SUPER DUPE.
Es gestattet, Programme von einem Band auf ein anderes zu kopieren. 
Zur Zwischenspeicherung dient ein Puffer, dessen Grenzen wie vor 
festzulegen sind. Ein zu kopierendes Programm muß mit seiner wirk- 
lichen Identität bzw. 00 oder mit seinem vollen Namen gesucht werden. 
Betätigung einer Taste löst Quickdump aus.

DICTRY lädt nichts, sondern bringt nur die alte Startadresse und 
ein weiteres Byte zur KIM-Anzeige. Dieses ist entweder die ID von 
einem BYTE oder das erste Zeichen des Namens (von 6 Zeichen). Nach 
Drücken einer Taste entspr. Anzeige für den nächsten Bandsatz.


