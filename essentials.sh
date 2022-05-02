#!/bin/bash
print_colored() {
    COLOR_PREFIX="\033[0;"
    GREEN="32m"
    RED="31m"
    GREY="37m"
    INFO="96m"
    NO_COLOR="\033[0m"
    if [ "$2" == "danger" ]; then
        COLOR="${COLOR_PREFIX}${RED}"
    elif [ "$2" == "success" ]; then
        COLOR="${COLOR_PREFIX}${GREEN}"
    elif [ "$2" == "debug" ]; then
        COLOR="${COLOR_PREFIX}${GREY}"
    elif [ "$2" == "info" ]; then
        COLOR="${COLOR_PREFIX}${INFO}"
    else
        COLOR="${NO_COLOR}"
    fi
    printf "${COLOR}%b${NO_COLOR}\n" "$1"
}

show_help() {
    print_colored "Invalid command-line argument" "danger"
    print_colored "You can pass --cli flag to view only cli packages" "info"
    exit 1
}

invalid_input(){
    print_colored "Invalid input..." "danger"
}


APT_GET_DIR=$(which apt-get)
ONLY_CLI=false
if [ "$1" == "--cli" ]; then
 ONLY_CLI=true
fi
if [ "$#" -gt 1 ] || [ "$1" != "--cli" ]; then
 show_help
fi
sudo true

# ***************
# Check Compatibility 
# ***************
print_colored "Checking Compatibility" ""
if [ -z "$APT_GET_DIR" ]; then
    print_colored "Compatibility check failed. Cannot find apt-get." "danger"
    print_colored "Exiting" "danger"
    exit 1
else
    print_colored "Compatibilty check passed" "success"
fi

# ***************
# Ask permissions 
# ***************
read -r -p $'\nUpgrade existing packages? [Y/n] ' upgrade_packages
upgrade_packages=${upgrade_packages:-Y}

read -r -p $'\nInstall git? [Y/n] ' install_git
install_git=${install_git:-Y}

read -r -p $'\nInstall pip for python 3? [Y/n] ' install_pip3
install_pip3=${install_pip3:-Y}

read -r -p $'\nInstall C/C++ compiler? [Y/n] ' install_gcc
install_gcc=${install_gcc:-Y}

if [ "$ONLY_CLI" == false ]; then
    read -r -p $'\nInstall Chrome? [Y/n] ' install_chrome
else
    install_chrome=n
fi
install_chrome=${install_chrome:-Y}

if [ "$ONLY_CLI" == false ]; then
    read -r -p $'\nInstall Spotify? [Y/n] ' install_spotify
else
    install_spotify=n
fi
install_spotify=${install_spotify:-Y}

if [ "$ONLY_CLI" == false ]; then
    read -r -p $'\nInstall VSCode? [Y/n] ' install_code
else
    install_code=n
fi
install_code=${install_code:-Y}

if [ "$ONLY_CLI" == false ]; then
    read -r -p $'\nInstall Postman? [Y/n] ' install_postman
else
    install_postman=n
fi
install_postman=${install_postman:-Y}

read -r -p $'\nInstall MongoDB? [Y/n] ' install_mongodb
install_mongodb=${install_mongodb:-Y}

read -r -p $'\nInstall NodeJS? [Y/n] ' install_nodejs
install_nodejs=${install_nodejs:-Y}

if [ "$ONLY_CLI" == false ]; then
    read -r -p $'\nInstall VLC? [Y/n] ' install_vlc
else
    install_vlc=n
fi
install_vlc=${install_vlc:-Y}

read -r -p $'\nInstall Terminator? [Y/n] ' install_terminator
install_terminator=${install_terminator:-Y}

read -r -p $'\nInstall Docker? [Y/n] ' install_docker
install_docker=${install_docker:-Y}

read -r -p $'\nInstall Docker Compose? [Y/n] ' install_docker_compose
install_docker_compose=${install_docker_compose:-Y}

print_colored "Updating Package List"  "success"
sudo apt update -y
sudo apt install python3.8
sudo apt install git -y
sudo apt install python3-pip python3-div
sudo -H pip3 install virtualenv
mkdir jupyter
cd jupyter
virtualenv environment  
source environment/bin/activate
pip install jupyter
case $install_pip3 in
    [yY][eE][sS]|[yY])
    print_colored "Installing pip3" "success"
    sudo apt install python3-pip -y
        ;;
    [nN][oO]|[nN])
    print_colored "Skipping pip3" "debug"
       ;;
    *)
 invalid_input
 exit 1
 ;;
esac

case $install_gcc in
    [yY][eE][sS]|[yY])
    print_colored "Installing C/C++ compiler" "success"
    sudo apt install build-essential manpages-dev -y
        ;;
    [nN][oO]|[nN])
    print_colored "Skipping C/C++ compiler" "debug"
       ;;
    *)
 invalid_input
 exit 1
 ;;
esac

case $install_code in
    [yY][eE][sS]|[yY])
    print_colored "Installing VSCode" "success"
    sudo snap install --classic code
    read -r -p $'\nInstall VSCode recommended extensions ? [Y/n] ' input
    input=${input:-Y}
    case $input in
        [yY][eE][sS]|[yY])
        print_colored "Installing extensions"     "success"
        code --install-extension christian-kohler.path-intellisense --user-data-dir="~/.vscode-root"
        code --install-extension CoenraadS.bracket-pair-colorizer --user-data-dir="~/.vscode-root"
        code --install-extension esbenp.prettier-vscode --user-data-dir="~/.vscode-root"
            ;;
        [nN][oO]|[nN])
        print_colored "Skipping extensions" "debug"
            ;;
        *)
    invalid_input
    exit 1
    ;;
    esac    
       ;;
    [nN][oO]|[nN])
    print_colored "Skipping VSCode" "debug"
       ;;
    *)
 invalid_input
 exit 1
 ;;
esac

case $install_postman in
    [yY][eE][sS]|[yY])
    print_colored "Installing Postman" "success"
    sudo snap install postman
        ;;
    [nN][oO]|[nN])
    print_colored "Skipping Postman" "debug"
       ;;
    *)
 invalid_input
 exit 1
 ;;
esac

case $install_terminator in
    [yY][eE][sS]|[yY])
    print_colored "Installing Terminator" "success"
    sudo apt-get install terminator -y
        ;;
    [nN][oO]|[nN])
    print_colored "Skipping Terminator" "debug"
       ;;
    *)
 invalid_input
 exit 1
 ;;
esac