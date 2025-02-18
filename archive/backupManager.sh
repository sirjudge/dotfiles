#!/bin/bash
# Configure new line and take in command line arguments
NEWLINE=$'\n'
while getopts 'a:s:c:b:sohir' flag; do
    case "${flag}" in
        a) action="${OPTARG}" ;;
        s) setup="${OPTARG}" ;;
        c) clean="${OPTARG}" ;;
        o) sourceBackup="${OPTARG}" ;;
        i) interactive="1" ;;
        r) archive="${OPTARG}" ;;
        h) echo\
            "i => [i]nteractive"\
            "a => [a]ction (restore/backup)${NEWLINE}"\
            "s => [s]etup to work on (office/personal)${NEWLINE}"\
            "c => [c]lean existing files and folders${NEWLINE}"\
            "o => s[o]urce list backup${NEWLINE}"\
            "r => a[r]chive existing .config${NEWLINE}"\
            "example Usage: Monitor.sh -a  backup -s office -c true"
            exit 1 ;;
        *) echo "Invalid flag provided, exiting${NEWLINE}"; exit 1 ;;
    esac
done

# Validation if interactive flag is not set
if [ "$interactive" == "0" ]; then
    invalidInput=0
    if [ "$action" == "" ]; then
        echo "Please provide an action to perform using the -a flag: '-a {restore/backup}'${NEWLINE}"
        invalidInput=1
    fi

    if [ "$setup" = "" ]; then
        echo "Please provide a setup to work on using the -s flag: '-s {office/personal}'${NEWLINE}"
        invalidInput=1
    fi

    if [ "$invalidInput" ]; then
        exit 1
    fi
fi

# Validation if interactive is set
if [ "$interactive" = "1" ]; then
    echo "Enter the setup to work on ([o]ffice/[p]ersonal):"
    read setup_input -r
    if [ "$setup_input" = "o" ]; then
        setup="office"
    elif [ "$setup_input" = "p" ]; then
        setup="personal"
    else
        echo "Invalid setup provided, exiting"
        exit 1
    fi

    echo "Enter the action to perform ([r]estore/[b]ackup):"
    read action_input -r
    if [ "$action_input" = "r" ]; then
        action="restore"
    elif [ "$action_input" = "b" ]; then
        action="backup"
    else
        echo "Invalid action provided, exiting"
        exit 1
    fi

    echo "Do you want to clean existing files and folders? ([y]es/[n]o)"
    read clean_input -r
    if [ "$clean_input" = "true" ]; then
        clean="true"
    elif [ "$clean_input" = "false" ]; then
        clean="false"
    else
        echo "Invalid clean input provided, exiting"
        exit 1
    fi

    echo "Do you want to backup the source list? (yes/no)"
    read sourceBackup_input -r
    if [ "$sourceBackup_input" = "y" ]; then
        sourceBackup="true"
    elif [ "$sourceBackup_input" = "n" ]; then
        sourceBackup="false"
    else
        echo "Invalid source backup input provided, exiting"
        exit 1
    fi
fi

if [ "$archive" = "1" ]; then
    echo "archiving existing .config/ folders"
    # Get today's date in YYYYMMDD format
    todaysDate=$(date +%Y%m%d%H%M%S)

    # Compress the config file and rename it
    cp -r "$HOME/.config" "$HOME/.config_$todaysDate"
fi


# Run office specific tasks
if [ "$setup" = "office" ]; then
    ./backupWork.sh "$action" "$clean" "$sourceBackup" "$archive" "$archive"

# Run personal specific tasks
elif [ "$setup" = "personal" ]; then
    ./backupPersonal.sh "$action" "$clean" "$archive"
fi

./backupShared.sh "$action" "$clean" "$archive"

currentPath=$(pwd)
if [ "$action" = "backup" ]; then
    if [ -n "$(git status --porcelain)" ]; then
        echo "Changes detected, do you want to push changes to git? (y/n)"
        read gitPush -r
        if [ "$gitPush" = "y" ]; then
            echo "pushing changes to git"
            cd ~/solutions/dotfiles || return
            git add .
            git commit -m "Automated file backup"
            git push
            cd "$currentPath" || return
        fi
    else
        echo "no changes detected, exiting"
    fi
fi

echo "$action $setup completed"
exit 1

