#!/bin/bash
# Program:
#   For auto write strings to all resource file

# input file, both operant or stdin
# filename=$HOME/'tmp.txt' # from grep, default naming 'tmp.txt'
filename=${1:-/dev/stdin}
exec < $filename

# execute folder
outputpath="$HOME/res/"  #in res/, default in $HOME

existfile=0
space="   "
while read line
do
#   echo $line # 一行一行印出內容
    a=`echo $line | awk -F ':' '{printf $1'}` #path
    b=`echo $line | awk -F ':' '{for (i=2; i <= NF; i++) {printf $i} printf "\n"}'` #string
#    echo $a
#    echo $b
    if [ -e ${outputpath}${a} ];then
        echo ${outputpath}${a} exists
        find ~/res/$a -type f -exec sed -i '/<\/resources>/i\'"$space$b" {} +
        ((existfile++))
    else
        echo ${outputpath}$a doesn\'t exists
    fi
done

echo exist file: $existfile
