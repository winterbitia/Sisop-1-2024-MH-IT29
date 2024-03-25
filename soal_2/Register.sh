#!/bin/bash

# Welcome message
echo -e "Welcome to the Registration System!\n"

# Email check
echo "Enter your email:" && read email
if echo "$email" | grep -vo "@"; then
    echo -e "\nPlease enter a valid email."
    echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER FAILED] ERROR Failed register attempt with error: "Invalid email": [$email]" >> log.txt
    exit 1
fi
if grep -q "^$email:.*:.*:.*:.*" users.txt; then
    echo -e "\nEmail already exists. Please choose a different one."
    echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER FAILED] ERROR Failed register attempt with error: "Email already exists": [$email]" >> log.txt
    exit 1
fi

# Username check
echo "Enter your username:" && read uname
if grep -q "^.*:$uname:.*:.*:.*" users.txt; then
    echo -e "\nUsername already exists. Please choose a different one."
    echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER FAILED] ERROR Failed register attempt with error: "Username already exists": [$uname]" >> log.txt
    exit 1
fi

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
echo -e "\nREGISTRATION SUCCESSFUL!\nUse login.sh to enter your account.\n"
echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER SUCCESS] user [$uname] register success" >> log.txt
