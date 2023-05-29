#!/bin/bash

case $1 in
    xanmod )
        if [ ! "$(grep -Rl xanmod /etc/apt/sources.list.d)" ]; then
          wget -qO - https://dl.xanmod.org/archive.key | sudo gpg --dearmor -o /usr/share/keyrings/xanmod-archive-keyring.gpg
          echo 'deb [signed-by=/usr/share/keyrings/xanmod-archive-keyring.gpg arch=amd64]  http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-release.list
        fi
        apt update
        exit
    ;;
    liquorix)
        if [ ! "$(grep -Rl liquorix /etc/apt/sources.list.d)" ]; then
          sudo curl -fsSLo /usr/share/keyrings/liquorix-keyring.gpg https://liquorix.net/liquorix-keyring.gpg
          echo "deb [arch=amd64 signed-by=/usr/share/keyrings/liquorix-keyring.gpg] https://liquorix.net/debian unstable main" | sudo tee /etc/apt/sources.list.d/liquorix.list
        fi
        apt update
        exit
    ;;

    *) exit ;;
esac
