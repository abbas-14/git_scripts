#!/bin/bash

GIT_HOOKS_DIR=".git/hooks"
DOWNLOAD_URL="http://localhost:3000/download-files"
CHECK_UPDATE_URL="http://localhost:3000/check-update"

subsub=$1

download_files () {
    # this function downloads all the files availabe
    FILES=$(curl -s "$DOWNLOAD_URL" | grep -oP '(?<=href=")[^"]+' | grep -v '/$')
    FOR FILE IN $FILES; do
        curl -s "$DOWLOAD_URL$FILE" -o "$GIT_HOOKS_DIR/$FILE"
        if [ $? -eq 0 ]; then
            echo "Downloaded: $FILE"
        else
            echo "Failed to download: $FILE"
        fi
    done
}

check_for_updates () {
    # this function checks for any new updates from cdn servers
    echo "checking for updates.."
    RESPONSE=$(curl -s "$API_URL")
    if [ "$RESPONSE" = "true" ]; then
        echo "Update available. Downloading files..."
        download_files
    else
        echo "Already upto date!."
    fi

}

make_git_init () {
    echo 'Git initialization with git make..'
}

make_git_feat () {
    echo 'Git initialization with git make..'
}

start () {
    if [ ! -f "$GIT_HOOKS_DIR/initialized.txt" ]; then
        echo "First time running the script."
        touch "$LOCAL_DIR/initialized.txt"
        download_files
    else
        check_update
        if [ $? -eq 0 ]; then
            echo "there was some issue checking for an update, please re-run the script"
        else
            echo "Failed to download: $FILE"
        fi
    fi
}

case "$1" in
    "init")
        make_git_init
        ;;
    "feature")
        make_git_feat
        ;;
    "update")
        check_for_updates
        ;;
    *)
        echo "Usage: $0 {init|feature}"
        exit 1
        ;;
esac



# at the start of the script
start
