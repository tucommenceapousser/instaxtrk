#!/bin/bash

trap 'echo exiting cleanly...; exit 1;' SIGINT SIGTSTP

checkroot() {
    if [[ "$(id -u)" -ne 1000 ]]; then
        printf "\e[1;77mPlease, run this program as root!\n\e[0m"
        exit 1
    fi
}

checkroot

(trap '' SIGINT SIGTSTP && command -v tor > /dev/null 2>&1 || { printf >&2  "\e[1;92mInstalling TOR, please wait...\n\e[0m"; apt-get update > /dev/null && apt-get -y install tor > /dev/null || printf "\e[1;91mTor Not installed.\n\e[0m"; }) & wait $!

(trap '' SIGINT SIGTSTP && command -v openssl > /dev/null 2>&1 || { printf >&2  "\e[1;92mInstalling openssl, please wait...\n\e[0m"; apt-get update > /dev/null && apt-get -y install openssl > /dev/null || printf "\e[1;91mOpenssl Not installed.\n\e[0m"; }) & wait $! 

(trap '' SIGINT SIGTSTP && command -v curl > /dev/null 2>&1 || { printf >&2  "\e[1;92mInstalling cURL, please wait...\n\e[0m"; apt-get update > /dev/null && apt-get -y install curl > /dev/null || printf "\e[1;91mCurl Not installed.\n\e[0m"; }) & wait $!

(trap '' SIGINT SIGTSTP && printf "\e[1;92mDownloading 10m.txt, please wait...\n\e[0m" && curl -o 10m.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10-million-password-list-top-1000000.txt) & wait $!

printf "\e[1;92mAll Requires are installed!\n\e[0m"