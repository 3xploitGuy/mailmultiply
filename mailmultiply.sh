#!/bin/bash

##### Colors Used #####
Red="\e[1;91m"
Green="\e[1;92m"
Yellow="\e[1;93m"
White="\e[1;97m"

##### Banner #####
banner () { clear
echo -e "${Red} __  __       _ _   __  __       _ _   _       _       
${Red}|  \/  |     (_) | |  \/  |     | | | (_)     | |      
${Red}| \  / | __ _ _| | | \  / |_   _| | |_ _ _ __ | |_   _ 
${Red}| |\/| |/ _\` | | | | |\/| | | | | | __| | '_ \| | | | |
${White}| |  | | (_| | | | ${Red}| |  | | |_| | | |_| | |_) | | |_| |
${White}|_|  |_|\__,_|_|_| |_|  |_|\__,_|_|\__|_| .__/|_|\__, |
${White}                                        | |       __/ |
${White}     Hola! Create Unlimited Gmails      |_|      |___/ \n
         \e[0;96mDeveloped by: ${Red}Sandesh (3xploitGuy)\n\n"
}

email () {

##### Input Email, validation based on regular expression #####
read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Enter email address : \e[1;97m' email
if [[ $email =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$ ]]; then
read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Number of mails to generate : \e[1;97m' number

##### Extracting name and domain from email #####
name=`echo $email | cut -d "@" -f 1`
domain=`echo $email | cut -d "@" -f 2`
echo -e "$White[${Red}!$White]$Red Generating :${White}\e[0;97m"
sleep 1

##### Email Generating #####
echo "import sys
def generator(name): 
 return [name] + [name[:i]+\".\"+right for i in range(1,len(name)) for right in generator(name[i:]) ]
for result in generator(sys.argv[1]):
 print(result)
" > temp.py
if [ $(($number / 2)) -gt $((2**(${#name} - 1))) ]; then
alias_number="$(( $number - (2**(${#name} - 1)) ))"
else
alias_number="$(($number / 2 ))"
fi
python3 temp.py $name > generated
rm temp.py
if [ $((number%2)) -eq 0 ]; then 
shuf -n $(( number / 2 )) generated > display
else
shuf -n $((( number / 2 ) + 1 )) generated > display
fi
rm generated
awk '$0=$0"@'$domain'"' display	> temp.lst
rm display
shuf -n $alias_number alias > names
awk '$0="'$name'+"$0"@'$domain'"' names  >> temp.lst
rm names
shuf temp.lst > $name.lst
rm temp.lst
cat $name.lst
trap "rm $name.lst &> /dev/null" EXIT

##### Save the generated output #####
read -p $'\n\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Do you want to save the output (y/n) : \e[1;97m' save_output
if [ "$save_output" = "Y" ] || [ "$save_output" = "y" ]; then

##### Check if output directory exists #####
if [ ! -d "output" ]; then
mkdir output 
fi
cp $name.lst output
echo -e "$White[${Yellow}*$White]$Yellow Output saved at : ${White}output/$name.lst"
echo -e "$White[${Red}!$White]$Red Exiting...\n"; exit
else 
rm $name.lst
echo -e "$White[${Red}!$White]$Red Exiting...\n"; exit
fi
else
echo -e "$White[${Red}!$White]$Red Invalid email address"
email 
fi
}
banner
email
