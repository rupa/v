#!/usr/bin/env bash

[ "$vim" ] || vim=vim
[ $viminfo ] || viminfo=~/.viminfo

usage="$(basename $0) [-a] [-l] [-[0-9]] [--debug] [--help] [regexes]"

[ $1 ] || list=1

fnd=()
for x; do case $x in
    -a) deleted=1;;
    -l) list=1;;
    -[0-9]) edit=${x:1}; shift;;
    --help) echo $usage; exit;;
    --debug) vim=echo;;
    --) shift; fnd+=("$@"); break;;
    *) fnd+=("$x");;
esac; shift; done
set -- "${fnd[@]}"

[ -f "$1" ] && {
    $vim "$1"
    exit
}

while IFS=" " read line; do
    [ "${line:0:1}" = ">" ] || continue
    fl=${line:2}
    [ -f "${fl/\~/$HOME/}" -o "$deleted" ] || continue
    match=1
    for x; do
        [[ "$fl" =~ $x ]] || match=
    done
    [ "$match" ] || continue
    i=$((i+1))
    files[$i]="$fl"
done < "$viminfo"

if [ "$edit" ]; then
    resp=${files[$((edit+1))]}
elif [ "$i" = 1 -o "$list" = "" ]; then
    resp=${files[1]}
elif [ "$i" ]; then 
    while [ $i -gt 0 ]; do
         echo -e "$((i-1))\t${files[$i]}"
         i=$((i-1))
    done
    read -p '> ' CHOICE
    [ "$CHOICE" ] && resp=${files[$((CHOICE+1))]}
fi

[ "$resp" ] || exit
$vim "${resp/\~/$HOME}"
