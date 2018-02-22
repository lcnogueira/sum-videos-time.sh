#!/bin/bash
#params
if [ -n "$1" ];then
    dir="$1"
else
    dir="$(pwd)"
fi
declare -a dir_array
#vars
separator="----------------------------------------------------------------------------"
#functions
printWithSeparator(){
    echo $separator
    echo $1
    echo $separator
}
printTime(){
    awk -v time="$1" 'BEGIN {print int(time/3600)":"int((time%3600)/60)":"int(time%60)}'
}
getTime(){
    /usr/bin/avprobe "$1" 2>&1 | grep Duration | awk -F[:,] '{print int($2*3600+$3*60+$4)}'
}
printFiles(){
    printWithSeparator "Dir: ${dir_array[$(($indx-1))]}"
    totalDir=0
    for i in "$1"/{*.mp4,*.mkv,*.avi,*.flv}
    do
        if [[ "$(getTime "$i")" -ne "0" ]];then
            echo -e "$(basename "$i")\t$(tput setaf 2)$(printTime $(getTime "$i"))$(tput sgr0)"
        fi
    done
}
add(){
    time=0;
    for i in "$1"/{*.mp4,*.mkv,*.avi,*.flv}
    do
        let time=time+$(getTime "$i") 2>/dev/null
    done
    echo $time
}
#main
echo "Calculating..."
case "$2" in
    #case recursive
    -R|-r) 
        tmp=$(find $dir -type d | xargs)
        dir_array=( $tmp )
        k=0;
        for indx in $(seq ${#dir_array[@]})
        do
            printFiles ${dir_array[$(($indx-1))]}
            totalDir=$(add ${dir_array[$(($indx-1))]})
            echo -e "$(tput setaf 1)SUM: $(printTime $totalDir)$(tput sgr0)"
            let k=k+totalDir
        done
        printWithSeparator "Total Time: $(tput setaf 1)$(printTime $k)$(tput sgr0)"
        ;;
    #case not recursive
    *) 
        printWithSeparator "Dir $dir"
        j=0
        for i in "$dir"/{*.mp4,*.mkv,*.avi,*.flv}
        do
            if [[ "$(getTime "$i")" -ne "0" ]];then
                echo -e "$(basename "$i")\t$(tput setaf 2)$(printTime $(getTime "$i"))$(tput sgr0)"
            fi
            let j=j+$(getTime "$i") 2>/dev/null
        done
        printWithSeparator "Total $(tput setaf 1)$(printTime $j)$(tput sgr0)"
        ;;
esac