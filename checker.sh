#!/bin/bash -


COMMAND="$1"
TARGET="$2"
OPTION="$3"
OPTION_TARGET="$4"

read -r -d '' HELP_MESSAGE << EOF
    Password and Email checker

    Usage:
        checker.sh <command> [<arg>] [options]

    Commands:
        password <password>:
            Check a password against the
            Have I Been Pwned? database

        email <email>: 
            check if email is pwned

        help: 
            Show this help message

    Options:
        -h, --help:
            Show this help message
        
        -b, --batch:
            Batch mode, do not prompt for input

    Examples:
        checker.sh password
        checker.sh password mypassword
        checker.sh email
EOF

if [ -z "$COMMAND" ]
then
    echo "$HELP_MESSAGE"
    exit 1
else 
    if [ "$COMMAND" == "password" ]
    then
        if [ -z "$TARGET" ]
        then
            echo "$HELP_MESSAGE"
            exit 1
        else
            if [ "$OPTION" == "-b" ] || [ "$OPTION" == "--batch" ]
            then
                cat "$OPTION_TARGET" | tr -d '\r' | while read fileLine
                do	
                    # TODO: file -> function???
                    ./checkemail.sh "$fileLine" > /dev/null
                    
                    if (( "$?" == 0 ))
                    then
                        echo "$fileLine is Pwned!"
                    fi
                    
                    sleep 0.25
                done
            else
                TARGET=$(echo -n "$TARGET" | shasum)
                TARGET=${TARGET:0:40}

                firstFive=${TARGET:0:5}
                ending=${TARGET:5}

                pwned=$(curl -s "https://api.pwnedpasswords.com/range/$firstFive" | \
                        tr -d '\r' | grep -i "$ending" )
                passwordFound=${pwned##*:}


                if [ "$passwordFound" == "" ]
                then
                    exit 1
                else
                    printf 'Password is Pwned %d Times!\n' "$passwordFound"
                    exit 0
                fi
            fi
        fi
    elif [ "$COMMAND" == "email" ]
    # Does NOT work. Because the version has been changed and now there is a charge for it.
    then
        if [ -z "$TARGET" ]
        then
            echo "$HELP_MESSAGE"
            exit 1
        else
            if [ "$OPTION" == "-b" ] || [ "$OPTION" == "--batch" ]
            then
                cat "$OPTION_TARGET" | tr -d '\r' | while read fileLine
                do	
                    # TODO: file -> function???
                    ./checkemail.sh "$fileLine" > /dev/null
                    
                    if (( "$?" == 0 ))
                    then
                        echo "$fileLine is Pwned!"
                    fi
                    
                    sleep 0.25
                done
            else
                echo "Checking email: $TARGET"
                pwned=$(curl -s "https://haveibeenpwned.com/api/v2/breachedaccount/$FIRST_ARG")

                if [ "$pwned" == "" ]
                then
                    exit 1
                else
                    echo 'Account pwned in the following breaches:'
                    echo "$pwned" | grep -oP '"Name":".*?"' | cut -d':' -f2 | tr -d '\"'
                    exit 0
                fi
            fi
        fi
    elif [ "$COMMAND" == "help" ]
    then
        echo "$HELP_MESSAGE"
    fi
fi
