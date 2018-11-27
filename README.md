# Play WoWS replay files on Linux

## Install
run `setup.sh` on terminal.

## How to play replays
Replay files are stored in `${WINEPREFIX}/dosdevices/c:/Games/World_of_Warships (or your own custom)/replays/`

1. Right click on a replay file (*.wowsreplay)
2. Choose "Open with World of Warships play replay"

## Contents
- ${XDG_DATA_HOME}/mime/packages/x-wine-wows-replay.xml
	- Add MIME-type for replay file named "application/x-wine-wows-replay"
- ${XDG_DATA_HOME}/applications/wows_replay.desktop
	- .desktop file to assagin replay files to the following launch script
- ${WINEPREFIX}/ *\<Path WoWS installed \>* /play_replay_wows.sh
	- Shell script to launch WoWS with replay file which modified to Windows file path

if $XDG_DATA_HOME is not set, default is equal to `${HOME}/.local/share`.

## Note
- WGC is not supported now.
- Replay files have to be placed under Wine drive configuration (can be described as Windows file path) and same $WINEPREFIX with WoWS installed.
- If you have installed WoWS plural (e.g. WoWS_NA and WoWS_RU), first one sorted by name will be chosen as replay environment.
