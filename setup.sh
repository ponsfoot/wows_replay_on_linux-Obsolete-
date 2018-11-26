#!/usr/bin/bash -e

IFS='
'

if [[ -z $XDG_DATA_HOME ]]; then
    XDG_DATA_HOME="${HOME}/.local/share"
fi

basedir=`dirname "$(readlink -f $0)"`
menudir=`ls -d "${XDG_DATA_HOME}/applications/wine/Programs/World of Warships"* | head -n1`
wineprefix=`sed -n 's/.*WINEPREFIX="\(.\+\)".*/\1/p' "${menudir}/World of Warships.desktop"`
linuxpath=`sed -n 's/Path=\(.\+\)/\1/p' "${menudir}/World of Warships.desktop"`
winpath=`sed -n 's|.*dosdevices/\(.\+\)|\1|p' <<< "$linuxpath"`
winpath=${winpath//\//\\\\\\\\}
launcher="${basedir}/play_replay_wows.sh"

sed "s|@WINEPREFIX@|${wineprefix}|g;s|@LINUXPATH@|${linuxpath}|g;s|@WINPATH@|${winpath}|g" "${basedir}/play_replay_wows.sh.templete" > "$launcher"
sed "s|@LAUNCHER@|${launcher}|g;s|@LINUXPATH@|${linuxpath}|g" "${basedir}/wows_replay.desktop.template" > "${XDG_DATA_HOME}/applications/wows_replay.desktop"
cp -af "${basedir}/x-wine-wows-replay.xml" "${XDG_DATA_HOME}/mime/packages/"

update-mime-database "${XDG_DATA_HOME}/mime/"
update-desktop-database "${XDG_DATA_HOME}/applications/"

chmod +x "$launcher"
