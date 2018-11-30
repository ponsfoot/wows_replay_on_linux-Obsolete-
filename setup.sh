#!/usr/bin/bash -e

IFS='
'

INSTALL=yes

while getopts 'uh' opt
do
    case $opt in
        u)
            INSTALL=
            ;;
        h)
            echo -e 'Usage: setup.sh [options]\n'
            echo -e '-u\tuninstall'
            echo -e '-h\tprint this help and exit'
            exit 0
            ;;
    esac
done

xdg_data_home="${XDG_DATA_HOME:-${HOME}/.local/share}"

basedir=`dirname "$(readlink -f $0)"`
progmenu="${xdg_data_home}/applications/wine/Programs/"

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

    if [[ ! `ls "$progmenu" | grep "^${name}.*"` ]]; then
        continue
    fi

    menudir=`ls -d "${progmenu}/${name}"* | head -n1`
    wineprefix=`sed -n 's/.*WINEPREFIX="\(.\+\)".*/\1/p' "${menudir}/${name}.desktop"`
    gamepath=`sed -n 's/Path=\(.\+\)/\1/p' "${menudir}/${name}.desktop"`
    launcher="${gamepath%/*}/play_replay_${abbr}.sh"
    desktop="${xdg_data_home}/applications/${abbr}_replay.desktop"
    mime="${xdg_data_home}/mime/packages/x-wine-${abbr}-replay.xml"

    if [[ $INSTALL ]]; then
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
            "${basedir}/wows_replay.desktop.template" > "$desktop"
        sed -e "s|@ABBR@|${abbr}|g" \
            -e "s|@NAME@|${name}|g" \
            "${basedir}/x-wine-wows-replay.xml.template" > "$mime"

        chmod 744 "$launcher"
    else
        for target in "$launcher" "$desktop" "$mime"
        do
            rm -f "$target"
        done
    fi
done

update-mime-database "${xdg_data_home}/mime/"
update-desktop-database "${xdg_data_home}/applications/"
