#!/usr/bin/bash -e

IFS='
'

xdg_data_home="${XDG_DATA_HOME:-${HOME}/.local/share}"

basedir=`dirname "$(readlink -f $0)"`

gamename=("World of Warships" "World of Tanks")
gameabbr=(wows wot)
gameicon=(F66B_WoWSLauncher.0 7680_WoTLauncher.0)
gameexe=(WorldOfWarships.exe WorldOfTanks.exe)

for i in 0 1
do
    name=${gamename[i]}
    abbr=${gameabbr[i]}
    icon=${gameicon[i]}
    exe=${gameexe[i]}

    menudir=`ls -d "${xdg_data_home}/applications/wine/Programs/${name}"* | head -n1`
    wineprefix=`sed -n 's/.*WINEPREFIX="\(.\+\)".*/\1/p' "${menudir}/${name}.desktop"`
    gamepath=`sed -n 's/Path=\(.\+\)/\1/p' "${menudir}/${name}.desktop"`
    launcher="${gamepath%/*}/play_replay_${abbr}.sh"

    sed -e "s|@WINEPREFIX@|${wineprefix}|g" \
        -e "s|@GAMEPATH@|${gamepath}|g" \
        -e "s|@ICON@|${icon}|g" \
        -e "s|@EXE@|${exe}|g" \
        "${basedir}/play_replay_wows.sh.template" > "$launcher"
    sed -e "s|@NAME@|${name}|g" \
        -e "s|@LAUNCHER@|${launcher}|g" \
        -e "s|@ABBR@|${abbr}|g" \
        -e "s|@GAMEPATH@|${gamepath}|g" \
        -e "s|@ICON@|${icon}|g" \
        "${basedir}/wows_replay.desktop.template" > "${xdg_data_home}/applications/${abbr}_replay.desktop"
    sed -e "s|@ABBR@|${abbr}|g" \
        -e "s|@NAME@|${name}|g" \
        "${basedir}/x-wine-wows-replay.xml.template" > "${xdg_data_home}/mime/packages/x-wine-${abbr}-replay.xml"

    chmod +x "$launcher"
done

update-mime-database "${xdg_data_home}/mime/"
update-desktop-database "${xdg_data_home}/applications/"
