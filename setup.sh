#!/usr/bin/bash -e

IFS='
'

xdg_data_home="${XDG_DATA_HOME:-${HOME}/.local/share}"

basedir=`dirname "$(readlink -f $0)"`
menudir=`ls -d "${xdg_data_home}/applications/wine/Programs/World of Warships"* | head -n1`
wineprefix=`sed -n 's/.*WINEPREFIX="\(.\+\)".*/\1/p' "${menudir}/World of Warships.desktop"`
linuxpath=`sed -n 's/Path=\(.\+\)/\1/p' "${menudir}/World of Warships.desktop"`
winpath=`sed -n 's|.*dosdevices/\(.\+\)|\1|p' <<< "$linuxpath"`
winpath=${winpath//\//\\\\\\\\}
launcher="${linuxpath%/*}/play_replay_wows.sh"

sed "s|@WINEPREFIX@|${wineprefix}|g;s|@LINUXPATH@|${linuxpath}|g;s|@WINPATH@|${winpath}|g" "${basedir}/play_replay_wows.sh.template" > "$launcher"
sed "s|@LAUNCHER@|${launcher}|g;s|@LINUXPATH@|${linuxpath}|g" "${basedir}/wows_replay.desktop.template" > "${xdg_data_home}/applications/wows_replay.desktop"
cp -af "${basedir}/x-wine-wows-replay.xml" "${xdg_data_home}/mime/packages/"

update-mime-database "${xdg_data_home}/mime/"
update-desktop-database "${xdg_data_home}/applications/"

chmod +x "$launcher"
