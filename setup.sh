#!/usr/bin/bash -e

IFS='
'

if [[ -z $XDG_DATA_HOME ]]; then
    XDG_DATA_HOME="${HOME}/.local/share"
fi

basedir=`dirname "$(readlink -f $0)"`
menudir=`ls -d "${XDG_DATA_HOME}/applications/wine/Programs/World of Warships"* | head -n1`
wineprefix=`sed -n 's/.*WINEPREFIX="\(.\+\)".*/\1/p' ${menudir}/World\ of\ Warships.desktop`
wowspath=`sed -n 's/Path=\(.\+\)/\1/p' ${menudir}/World\ of\ Warships.desktop`
wowstop=`basename $wowspath`
launcher="${basedir}/play_replay_wows.sh"

sed -e "s|@WINEPREFIX@|${wineprefix}|g;s|@WOWSTOP@|${wowstop}|g" "${basedir}/play_replay_wows.sh.templete" > "$launcher"
sed -e "s|@LAUNCHER@|${launcher}|g;s|@WOWSPATH@|${wowspath}|g" "${basedir}/wows_replay.desktop.template" > "${XDG_DATA_HOME}/applications/wows_replay.desktop"
cp -af "${basedir}/x-wine-wows-replay.xml" "${XDG_DATA_HOME}/mime/packages/"

update-mime-update "${XDG_DATA_HOME}/mime"
update-desktop-database "${XDG_DATA_HOME}/applications/"
