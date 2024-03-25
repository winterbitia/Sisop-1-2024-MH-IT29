#!/bin/bash

adduser() {
    # Email check
    echo "Enter your email:" && read email
    if echo "$email" | grep -vo "@"; then
        echo -e "\nPlease enter a valid email."
        echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER FAILED] ERROR Failed register attempt with error: "Invalid email": [$email]" >> auth.log
        return 1
    fi
    if grep -q "^$email:.*:.*:.*:.*" users.txt; then
        echo -e "\nEmail already exists. Please choose a different one."
        echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER FAILED] ERROR Failed register attempt with error: "Email already exists": [$email]" >> auth.log
        return 1
    fi

    # Username input
    echo "Enter your username:" && read uname

    # Security question
    echo "Enter a security question:" && read sec_q
    echo "Enter a security answer:" && read sec_a

    # Password check
    echo -e "Enter password:\n(min 8 chars, 1 uppercase, 1 lowercase, 1 digit, 1 symbol)"
    read -s pass
    while true; do
        if [[ ${#pass} -ge 8
            && "$pass" == *[[:lower:]]*
            && "$pass" == *[[:upper:]]*
            && "$pass" == *[0-9]* ]]; then
            break
        else
            echo "Password does not meet the requirements"
            echo "Enter password:"
            read -s pass
        fi
    done

    # Add base64 encryption
    encrypt=`echo $pass | base64`

    # Add to users.txt
    echo "$email:$uname:$sec_q:$sec_a:$encrypt" >> users.txt
    echo -e "\nREGISTRATION SUCCESSFUL!\n "
    echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER SUCCESS] user [$uname] register success" >> auth.log
}


admin() {
    return 0
}

member() {
    echo -e "\nWelcome! You have member privileges.\n"
    return 0
}

loginuser() {
    # Email check
    echo "Enter your email:" && read email
    if ! grep -q "^$email:" users.txt; then    
        echo -e "\nEmail not found."
        return 1
    else
        # Password check
        echo "Enter password:" && read -s pass
        uname=`awk -F: -v email=$email '$0~email {print $2}' users.txt`
        encrypt=`echo $pass | base64`

        # Admin login
        if grep -q "^$email:.*:.*:.*:$encrypt" users.txt && echo "$email" | grep -q "admin"; then
                echo -e "\nLogin successful\n"
                echo "$(date '+[%d/%m/%y %H:%M:%S]') [LOGIN SUCCESS] user [$uname] login success" >> auth.log
                admin
        # Member login
        elif grep -q "^$email:.*:.*:.*:$encrypt" users.txt; then
                echo -e "\nLogin successful\n"
                echo "$(date '+[%d/%m/%y %H:%M:%S]') [LOGIN SUCCESS] user [$usr] login success" >> auth.log
                member
        # Fail login
        else
                echo -e "\nPassword is incorrect. Please enter the correct password."
                echo "$(date '+[%d/%m/%y %H:%M:%S]') [LOGIN FAILED] ERROR Failed login attempt on user with email [$email]" >> auth.log
                return 1  
        fi
    fi
}

i_forgor() {
    # Email check
    echo "Enter your email:" && read email
    if ! grep -q "^$email:" users.txt; then    
        echo -e "\nEmail not found."
        return 1
    else
        sec_q=`awk -F":" -v email=$email '$0~email {print $3}' users.txt`
        echo "Security question: $sec_q"

        echo "Enter your answer:" && read sec_a
        if ! grep -q "^$email:.*:.*:$sec_a" users.txt; then
            echo -e "\nIncorrect answer."
            return 1
        else
            encrypt=`awk -F":" -v email=$email '$0~email {print $5}' users.txt`
            pass=`echo $encrypt | base64 -d`
            echo -e "\nYour password is: $pass\n"
        fi
    fi
}


# Start program
echo "Welcome to the Login Page. Please select an option:"
echo "1. Login"
echo "2. Forgot Password"
echo "Choose an option: " && read opt

# PASSWORD TEST == En!gma26

case $opt in
1) loginuser ;;
2) i_forgor ;;
*) echo "Invalid option" ;;
esac