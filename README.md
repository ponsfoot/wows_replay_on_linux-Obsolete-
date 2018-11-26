# Play WoWS replay files on Linux

## Steps to setup
If `${XDG_DATA_HOME}` is not set, default is equal to `${HOME}/.local/share/`.

1. Copy `x-wine-wows-replay.xml` to your `${XDG_DATA_HOME}/mime/packages/`
2. Copy `play_replay_wows.sh` to your directory which stores executables
3. Edit `WINEPREFIX=` and path of WorldOfWarships.exe in `play_replay_wows.sh` to your `$WINEPREFIX`
4. Copy `wows_replay.desktop` to your `${XDG_DATA_HOME}/applications/`
5. Edit path in `wows_replay.desktop` as follows:
	- `Exec=` to your `play_replay_wows.sh`
	- `Path=` to your WoWS installed
6. Update mime and desktop database
	- `$ update-desktop-database ${XDG_DATA_HOME}/applications/`
	- `$ update-mime-database ${XDG_DATA_HOME}/mime/`


