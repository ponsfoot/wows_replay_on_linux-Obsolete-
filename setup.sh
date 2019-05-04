#!/usr/bin/bash -e

IFS='
'

INSTALL=true

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
progmenu="${xdg_data_home}/applications/wine/Programs"

candname=("World_of_Warships" "World_of_Tanks")
candabbr=(wows wot)
candexe=(WorldOfWarships.exe WorldOfTanks.exe)

gamename=()
gamepath=()
gamewprfx=()
gameicon=()
gameabbr=()
gameexe=()

if [[ -d "${progmenu}/Wargaming.net" ]]; then
    wgcdesktop="${progmenu}/Wargaming.net/Wargaming.net Game Center.desktop"
    wgcdata=`sed -n 's/Path=\(.\+\)/\1/p' "$wgcdesktop"`
    wkdirs=`sed -rn 's|.*<working_dir>(.+)</working_dir>|\1|gp' "${wgcdata}/preferences.xml"`
    wprfx=`sed -n 's/.*WINEPREFIX="\(.\+\)".*/\1/p' "$wgcdesktop"`

    for ((i=0; i < ${#candname[@]}; i++)) {

        name=${candname[i]}
        abbr=${candabbr[i]}
        exe=${candexe[i]}

        path=`grep "$name" <<< "$wkdirs" | grep -vm1 _[CP]T$`
        if [[ -z $path ]]; then
            continue
        fi

        path=${path,}
        path=${path//\\/\/}
        path="${wprfx}/dosdevices/${path}"

        menudir=`ls -d "${progmenu}/Wargaming.net/${name}"* | grep -vm1 _[CP]T$`
        menuname=`basename ${menudir}`
        if [[ -f "${menudir}/${menuname}.desktop" ]]; then
            desktop="${menudir}/${menuname}.desktop"
        else
            desktop="${menudir}/${menuname//_/ }.desktop"
        fi

        icon=`sed -n 's/Icon=\(.\+\)/\1/p' "$desktop"`

        gamename+=("${name//_/ }")
        gamepath+=("$path")
        gamewprfx+=("$wprfx")
        gameicon+=($icon)
        gameabbr+=($abbr)
        gameexe+=($exe)
    }

else
    for ((i=0; i < ${#candname[@]}; i++)) {

        name=${candname[i]//_/ }
        abbr=${candabbr[i]}
        exe=${candexe[i]}

        menudir=`ls -d "${progmenu}/${name}"* | grep -vm1 Test$`
        if [[ -z $"menudir" ]]; then
            continue
        fi

        wprfx=`sed -n 's/.*WINEPREFIX="\(.\+\)".*/\1/p' "${menudir}/${name}.desktop"`
        path=`sed -n 's/Path=\(.\+\)/\1/p' "${menudir}/${name}.desktop"`
        icon=`sed -n 's/Icon=\(.\+\)/\1/p' "${menudir}/${name}.desktop"`

        gamename+=("$name")
        gamepath+=("$path")
        gamewprfx+=("$wprfx")
        gameicon+=($icon)
        gameabbr+=($abbr)
        gameexe+=($exe)
    }
fi

for ((i=0; i < ${#gamename[@]}; i++)) {

    name=${gamename[i]}
    path=${gamepath[i]}
    wprfx=${gamewprfx[i]}
    icon=${gameicon[i]}
    abbr=${gameabbr[i]}
    exe=${gameexe[i]}

    launcher="${path%/*}/play_replay_${abbr}.sh"
    desktop="${xdg_data_home}/applications/${abbr}_replay.desktop"
    mime="${xdg_data_home}/mime/packages/x-wine-${abbr}-replay.xml"

    if [[ $INSTALL ]]; then
        sed -e "s|@WINEPREFIX@|${wprfx}|g" \
            -e "s|@GAMEPATH@|${path}|g" \
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
}

update-mime-database "${xdg_data_home}/mime/"
update-desktop-database "${xdg_data_home}/applications/"
