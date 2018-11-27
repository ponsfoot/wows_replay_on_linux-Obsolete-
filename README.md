# Play WoWS replay files on Linux

## Install
run `setup.sh` on terminal.

## How to play replays
1. Open `replays` directory under */Path/to/WoWS/installed/* on Filemanager
2. Right click on a replay file (*.wowsreplay)
3. Choose "Open with World of Warships play replay"

## Contents
- ${XDG_DATA_HOME}/mime/packages/x-wine-wows-replay.xml
	- Add MIME-type for replay file named "application/x-wine-wows-replay"
- ${XDG_DATA_HOME}/applications/wows_replay.desktop
	- .desktop file to assagin replay files to the following launch script
- $WINEPREFIX/ *\<directory WoWS installed (c:/Game/)\>* /play_replay_wows.sh
	- Shell script to launch WoWS with replay file which modified to Windows path

if ${XDG_DATA_HOME} is not set, default is equal to `${HOME}/.local/share`.
