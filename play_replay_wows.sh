#!/usr/bin/bash -e

replayfile="`basename $1`"

env WINEPREFIX="${HOME}/.wine32" /usr/bin/wine C:\\windows\\command\\start.exe /Unix ${HOME}/.wine32/dosdevices/c:/Games/World_of_Warships/WorldOfWarships.exe "C:\\Games\\World_of_Warships\\replays\\$replayfile"

