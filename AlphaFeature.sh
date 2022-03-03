#!/bin/bash

#This is a simple password validator written in Bash, it checks if a string argument passed along with the .sh file execution passes the criteria for a password.
#Criteria for the password are: at least 10 characters long, must contain 1 upper case and 1 lower case letter, and at least one digit.
#The functions that check the string use regex in order to do so.



argument=$1
getopts ":f:" option
path="" #Variable that stores the password file path when using option -f.
pass="" #Password that will be validated.
valid=0 #Variable that is changed to 1 if criteria for the password is not met. 

RED='\033[0;31m' #Red color
GREEN='\033[0;32m' #Green color
NC='\033[0m' #No Color




#Checks if password does not contain at least 1 digit.
function digitPresent {
    if ! [[ $pass =~ [1-9] ]]
    then
        printf "${RED}Please include at least 1 digit in your password. ${NC}\n"
        valid=1
    fi
}

#Checks if password does not contain at least 1 lower case letter.
function lowerCasePresent {
    if ! [[ $pass =~ [a-z] ]]
    then
        printf "${RED}Please include at least 1 lower case letter in your password. ${NC}\n"
        valid=1
    fi
}

#Checks if password does not contain at least 1 upper case letter.
function upperCasePresent {
    if ! [[ $pass =~ [A-Z] ]]
    then
        printf "${RED}Please include at least 1 upper case letter in your password. ${NC}\n"
        valid=1
    fi  
}

#Checks if password is at least 10 chars long.
function lengthSufficient {
    if ! [[ $pass =~ .{10,} ]]
    then
        printf "${RED}Please make sure the password is at least 10 characters long. ${NC}\n"
        valid=1
    fi
}


#This function calls all the necesarry functions to check the passwords strength and notfies the user if the password is valid, returns 0 for success or 1 for failure.
function checkPasswordStrength {
    lengthSufficient
    upperCasePresent
    digitPresent
    lowerCasePresent
    if [ $valid == 0 ]
    then
        printf "${GREEN}The password is valid.${NC}\n"
        return 0
    else
        return 1
    fi
}




#Checking if the argument accepted is an option or a password string.
function checkIfOption {
    if [[ $argument =~ ^\-.$ ]]
        then
        printf "it's -f\n"
        #getopts ":f:" option 
        if [ $option == "f" ]
        then
            path=${OPTARG}
            pass=$(cat $path 2>/dev/null)
            return 0
        fi
    else
        #printf "it's not -f\n"
        pass=$argument
        return 1
    fi
}

#checkIfOption

#If statement that checks for any errors with the flag letter or argument before validating password.
function checkOptionErrors {
    if [ $option == ? ]
    then
        printf "${RED}Please input the correct option letter, this script can only accept \"-f\" as an option. followed by a path to the file containing the password.${NC}\n"
        return 1
    elif [ $option == : ] || [ ! -f "$path" ]
    then
        printf "${RED}File could not be found${NC}\n"
        return 1
    else
        #printf "checkd\n"
        return 0
    fi
}

function validatePassword {
        if checkIfOption
        then
            if checkOptionErrors
            then
                checkPasswordStrength
            fi
        else
            checkPasswordStrength
        fi
}

# function validatePassword {
#     if [ checkIfOption -a checkOptionErrors ]
#     then
#         checkPasswordStrength
#     fi
#}

# function validatePassword {
#         if checkIfOption && checkOptionErrors
#         then
#             checkPasswordStrength
#         else
#             checkPasswordStrength
#         fi
# }



validatePassword
printf "\nThe option is: $option\nThe # is: $#\nThe OPTARG is: $OPTARG\nThe OPTINT is: $OPTIND\nThe pass is: $argument\nOption or pass: $checkIfOption\n" 

