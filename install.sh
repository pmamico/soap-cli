#!/usr/bin/env bash

uname="$(uname)"
if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X platform
    sudo curl -o /usr/local/bin/soap -s https://raw.githubusercontent.com/pmamico/soap-cli/main/src/soap && sudo chmod +x /usr/local/bin/soap
    INSTALL_PATH=/usr/local/bin/soap
    if ! command -v xmlstarlet &> /dev/null
    then
        brew install xmlstarlet
    fi
elif [ "${uname:0:5}" == "Linux" ]; then
    # GNU/Linux platform
    sudo curl -o /usr/local/bin/soap -s https://raw.githubusercontent.com/pmamico/soap-cli/main/src/soap && sudo chmod +x /usr/local/bin/soap
    INSTALL_PATH=/usr/local/bin/soap
    if ! command -v xmlstarlet &> /dev/null
    then
        sudo snap install xmlstarlet
    fi
elif [ "${uname:0:10}" == "MINGW32_NT" ]; then
    # 32 bits Windows NT platform
    curl -o "$HOME/bin/soap" -s https://raw.githubusercontent.com/pmamico/soap-cli/main/src/soap
    INSTALL_PATH="$HOME/bin/soap"
    if ! command -v xmlstarlet &> /dev/null
    then
        "xmlstarlet is missing, please install it"
    fi
elif [ "${uname:0:10}" == "MINGW64_NT" ]; then
    # 64 bits Windows NT platform
    curl -o "$HOME/bin/soap" -s https://raw.githubusercontent.com/pmamico/soap-cli/main/src/soap
    INSTALL_PATH=$HOME/bin/soap
    if ! command -v xmlstarlet &> /dev/null
    then
        "xmlstarlet is missing, please install it"
    fi
fi

if test -f "$INSTALL_PATH"; then
    echo "$(soap --version) successfully installed. ($INSTALL_PATH)"
else 
    echo "Failed to install soap-cli"
fi