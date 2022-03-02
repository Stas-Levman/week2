#!/bin/bash

pass=$1

length=${#pass}

valid=0

RED='\033[0;31m' #Red color
GREEN='\033[0;32m' #Green color
NC='\033[0m' #No Color


#Checking if password contains at least 1 digit.
function digitPresent {
    if [[ $pass =~ [1-9] ]]
    then
        # printf "1\n"
        return 0
    else
        printf "${RED}Please include at least 1 digits in your password. ${NC}\n"
        valid=1
        return 1
    fi
}

#Checking if password contains at least 1 lower case letter.
function lowerCasePresent {
    if [[ $pass =~ [a-z] ]]
    then
        # printf "2\n"
        return 0
    else
        printf "${RED}Please include at least 1 lower case letter in your password. ${NC}\n"
        valid=1
        return 1
    fi
}

#Checking if password contains at least 1 upper case letter.
function upperCasePresent {
    if [[ $pass =~ [A-Z] ]]
    then
        # printf "3\n"
        return 0
    else
        printf "${RED}Please include at least 1 upper case letter in your password. ${NC}\n"
        valid=1
        return 1
    fi  
}

#Checking if password is at least 10 chars long.
function lengthSufficient {
    if [[ $pass =~ .{10,} ]]
    then
        # printf "4\n"
        return 0
    else
        printf "${RED}Please make sure the password is at least 10 characters long. ${NC}\n"
        valid=1
        return 1
    fi
}

#Checking for any special characters or spaces/new lines/tabs.
function noSpacesOrSpecialChars {
    if [[ $pass =~ [[:punct:]] || $pass =~ [[:space:]] ]] 
    then
        printf "${RED}Please make sure there are no spaces or special characters in your password. ${NC}\n"
        valid=1
        return 1
    else
        # printf "5\n"
        return 0
    fi
}


#This function calls all the necesarry functions to check it's strength and notfies the user if the password is valid.
function checkPasswordStrength {
    lengthSufficient
    upperCasePresent
    digitPresent
    lowerCasePresent
    noSpacesOrSpecialChars
    if [ $valid == 0 ]
    then
        printf "${GREEN}match. $length${NC}\n"
        return 0
    else
        printf "${RED}no match. $length${NC}\n"
        return 1
    fi
}


checkPasswordStrength;





