# Enable to watch WoT & WoWS replays on Linux
Only **"Classic Launcher"** is supported (WGC is not supported).

## Install
1. Clone git repo or download and extract zip file
2. run `setup.sh`

## How to watch replays
Replay files are stored in `${WINEPREFIX}/dosdevices/c:/Games/World_of_{Tanks,Warships}* (or your own custom)/replays/`

1. Right click on a replay file (\*.wotreplay/\*.wowsreplay)
2. Choose "Open with World of Tanks/Warships play replay"

## What files are installed
- ${XDG_DATA_HOME}/mime/packages/x-wine-wot-replay.xml
- ${XDG_DATA_HOME}/mime/packages/x-wine-wows-replay.xml
- ${XDG_DATA_HOME}/applications/wot_replay.desktop
- ${XDG_DATA_HOME}/applications/wows_replay.desktop
- ${WINEPREFIX}/ *\<Path WoT installed \>* /play_replay_wowt.sh
- ${WINEPREFIX}/ *\<Path WoWS installed \>* /play_replay_wows.sh

if $XDG_DATA_HOME is not set, default is equal to `${HOME}/.local/share`.
if $WINEPREFIX is not set, default is equal to `${HOME}/.wine`.

## Uninstall
run `setup.sh -u`

## Note
- Replay files have to be placed under Wine drive configuration (can be described as Windows file path) and same $WINEPREFIX with WoT/WoWS installed ("drive_c/users/ *\<user\>* /My Documents" is symbolic link to your "${HOME}/ *\<user\>* /Documents").
- If you have installed WoT/WoWS plural (e.g. WoWS_NA and WoWS_RU), first one sorted by name will be chosen as replay environment.
