# Quickdump_Versaload-for-KIM-1

The lovely couple of Quickdump and Versaload

A double speed loader for the KIM-1 with relocating and linking.

by John Oliver and Roland Löhr August 1978

John Oliver, Ass. Professor of Astronomy at the University of Florida, doubled the speed of writing and reading magnetic tape as compared to Jim Butterfield's HYPERTAPE  by coding each byte with only 8 bits instead of two ASCII characters. Prof. Oliver gave kind permission to print his Superload and Superdum in this journal The editor nevertheless decided to put the nucleus of these two into anorter frame in order to win new features and to combine it to other useful utilities.

Thankful acknowlegement is made to Mr. Oliver for co-authoring his grand idea which formed the basis for all of this:

By now we have writing or reading 1 kbytes in about 12 seconds, 
input to old locations or relocated, open end input or protection of 
memory by buffer, DIRECTORY, DUPE, calling records by single-byte ID 
or by name (header of any 6 bytes). And together with the editor's
RALOAD (first issue of 65xx MICRO MAG): Relocation of programs to new 
address space, a linking loader with same transformation. Last, not 
least the option to introduce 'external parameters' aside from header.
QUICKDUMP and VERSALOAD are a dependent pair, they are not compatible 
with other recording formats.

_in German_
Jim Butterfield's HYPERTAPE beschleunigt das Bandschreiben und -laden 
um den Faktor 6. Sehr nützlich ist auch sein SUPER DUPE (Kopieren von 
Bandcassetten) und sein DIRECTORY (Lesen von Startadresse und ID vom
Band ohne zu laden).

Den nächsten großen Schritt machte John Oliver, Astronomie-Professor 
an der University of Florida, Williamson Hall, Gainesville FL 32611, 
mit seinen Programmen SUPER DUMP und SUPERLOAD, zuerst veröffentlicht 
in den KIM User Notes 7/8. Im KIM-Mortor und auch noch in HYPERTAPE 
wird jedes Zeichen zunächst in 2 ASCII-codierte Sequenzen zerlegt und 
gesendet. John Oliver verdoppelt die Geschwindigkeit auf etwa 1 kBytes 
in 12 Sekunden, indem er je Byte nur einmal 8 Bits sendet; eine klare 
logische Konsequenz, auf die jemand erst kommen mußte.

Wie beim KIM, so wird auch hier das einzelne bit durch verschiedene und 
verschieden lange Frequenzen auf dem Magnetband abgebildet. (Zur 
Erläuterung: s. KILOBAUD, Heft 11/77, S. 66 ff.). Soweit als möglich 
verwenden beide Autoren Unterprogramme des KIM-Monitors und trixen
sie z.T. aus.

John Oliver erteilte diesem Journal freundlichst Nachdruckrechte seiner 
Programme. Wir haben ihm dafür herzlich zu danken, denn sein Brief 
ermutigte in mehr als einwöchiger intensiver Arbeit eigene Weiterent- 
wicklungen, die hier als QUICKDUMP und VERSALOAD präsentiert werden.
