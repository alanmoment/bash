#! /bin/bash

NORMAL=`printf "\E[0;37;m"`
BOLD_NORMAL=`printf "\E[1;37;40m"`
BLUE=`printf "\E[0;34;40m"`
GREEN_BLUE=`printf "\E[0;36;40m"`
YELLOW=`printf "\E[0;33;40m"`
RED=`printf "\E[0;31;40m"`
RED_UNDERLINE=`printf "\E[4;31;40m"`

if [ ! -d .git ]; then
    echo "Here is not git repository."
    exit
fi

git=$(which git)
remoteList=($(git remote show))
remoteCount=${#remoteList[@]}

show_menu(){
    echo "${GREEN_BLUE}Remote list：${NORMAL}"
    for ((i=0; i<$remoteCount; i++)); do
        pushUrl=`git remote show -n ${remoteList[$i]} | grep 'Push' | awk -F "Push  " '{print $2}'`
        echo "${YELLOW}$((i+1)))${NORMAL} ${BOLD_NORMAL}${remoteList[$i]}${NORMAL} [${RED_UNDERLINE}$pushUrl${NORMAL}]"
    done
    echo "${YELLOW}$((remoteCount+1)))${NORMAL} All remote"
    echo "\n"
    # echo "${MENU}******************************${NORMAL}"
    echo "Which remote do you want? Or you can ${RED}enter to exit. ${NORMAL}"
    read opt
}

function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-\"${RESET}Error: No message passed\"}
    echo "${COLOR}${MESSAGE}${RESET}"
}

branch=`git branch | sed -n '/\* /s///p'`
show_menu
while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then 
        exit;
    else
        opt=$((opt-1))
        if [ $opt -gt $((remoteCount)) ]; then
            option_picked "Pick an option from the menu";
            show_menu;
        else
            # 如果選擇全部的 remote
            if [ $opt -eq $((remoteCount)) ]; then
                option_picked "All remote is Picked."
            else
                option_picked "${remoteList[$opt]} is Picked."
            fi

            read -r -p "Are you sure push branch \"${RED_UNDERLINE}${branch}${NORMAL}\" to remote?${YELLOW} [y/N]${NORMAL} " response
            case $response in
                [yY][eE][sS]|[yY]) 
                    # 如果選擇全部的 remote
                    if [ $opt -eq $((remoteCount)) ]; then
                        for ((i=0; i<$remoteCount; i++)); do
                            echo "push to ${remoteList[$i]}${NORMAL}"
                            git push ${remoteList[$i]} ${branch}
                        done
                    else
                        echo "push to ${remoteList[$opt]}${NORMAL}"
                        git push ${remoteList[$opt]} ${branch}
                    fi
                    exit;
                    ;;
                *)
                    exit;
                    ;;
            esac
        fi
    fi
done