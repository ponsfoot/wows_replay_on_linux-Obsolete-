# Play WoWS replay files on Linux

## Install
run `setup.sh`

## How to play replays
1. Open `replays` directory under */Path/to/WoWS/installed/* on Filemanager
2. Right click on replay file (*.wowsreplay)
3. Choose "Open with World of Warships play replay"

## Contents
- ${XDG_DATA_HOME}/mime/packages/x-wine-wows-replay.xml
	- Add MIME-type for replay file named "application/x-wine-wows-replay"
- ${XDG_DATA_HOME}/applications/wows_replay.desktop
	- .desktop file to assagin replay files to WoWS
- wows_replay_on_linux-master/play_replay_wows.sh
	- Shell script to launch replay file which modifies the path to Windows style
	- If you move this script somewhere, you should modify ${XDG_DATA_HOME}/applications/wows_replay.desktop (Exec=)

