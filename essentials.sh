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
# // following commands use for install data science Libraries 
pip install numpy
pip install pandas
pip install seaborn
pip install matplotlib
pip install matplotlib.pyplot
pip install sklearn
pip install nltk
pip install math
pip install scipy
pip install pylab
pip install sklearn.model_selection
pip install warnings
sudo apt install software-properties-common apt-transport-https wget
sudo apt install code

# // following commands to install Hadoop
sudo apt install openjdk-8-jdk -y
sudo apt install openssh-server openssh-client -y
sudo adduser hdoop
su - hdoop
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ssh localhost
wget https://downloads.apache.org/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
tar xzf hadoop-3.2.1.tar.gz
