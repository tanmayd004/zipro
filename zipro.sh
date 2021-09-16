#!/usr/bin/bash

version=1.0

###############| COLOR VARIABLES |###############

WHITE1='\033[1;97m'

RED1='\033[1;31m'

GREEN1='\033[1;32m'

BLUE1="\033[1;34m"

YELLOW1="\033[1;33m"

CYAN1='\033[1;96m'

PURPLE1="\033[1;35m"

CAFE="\033[0;33m"

L_RED="\033[1;37;41m"

NC='\033[0m'

#################################################

 declare -r TRUE=0

 declare -r FALSE=1

 flag=$FALSE

 counter=0

 chars_1=`echo {a..z}`

 chars_2=`echo {A..Z}`

 chars_3=`echo {0..9}`

 chars_4="~ ! @ \$ % ^ - _ = + { } [ ] : , . / ?"

 function cracker()

 {

     pass=$1

     echo -e "\n ${CYAN1}trying Password : ${PURPLE1}$pass${NC}"

     counter=$(($counter + 1))

     unzip -P $pass -o $file_name

     [ $? -eq 0 ] && END=$(date +%s) DIFF=$(( $END - $START )) && clear && banner && echo -e "${WHITE1}[${GREEN1}~${WHITE1}] ${CYAN1}Password Found : ${GREEN1}$pass${NC}" && echo -e "${WHITE1}[${GREEN1}~${WHITE1}] ${CYAN1}Password Tried : ${GREEN1}$counter${NC}" && echo -e "${WHITE1}[${GREEN1}~${WHITE1}] ${CYAN1}Time Taken     : ${GREEN1}$DIFF seconds${NC}" && return $TRUE || return $FALSE

 }

 function word_gen()

 {

     args=$1

     [ ${#args} -ge $length ] && cracker $1 && echo -e "${WHITE1}[${GREEN1}~${WHITE1}] ${CYAN1}Status         : ${GREEN1}Password Cracked${NC}\n${WHITE1}[${GREEN1}~${WHITE1}] ${CYAN1}Mode           : ${GREEN1}Bruteforce${NC}" && flag=$TRUE && exit

    if [ ${#args} -lt $length ]; then

         for c in $chars; do

             word_gen $1$c

         done

     fi

 }

function is_num()

 {

     [ $is_num -eq $is_num ] > /dev/null 2>&1

     return $?

 }

zip_input()

{

  read -p $'\e[1;97m[\e[1;32m~\e[1;97m] \e[1;96mPlease Enter Full Path Of Zip : \e[0m' zip_file

while :

do

if [[ -f "$zip_file" ]]

then

   file_name=$zip_file

   break

else

   echo -e "    ${RED1}Zip File Not Found !!${NC}" && zip_input

fi

done

}

pswd_input()

{

   read -p $'\e[1;97m[\e[1;32m~\e[1;97m] \e[1;96mPlease Enter Full Path Of Password List : \e[0m' pswd_file

while :

do

if [[ -f "$pswd_file" ]]

then

   pswd_list=$pswd_file

   break

else

   echo -e "    ${RED1}Password List Not Found !!${NC}" && pswd_input

fi

done

}

function brute_force()

{

     clear

     banner

     read -p $'\e[1;97m[\e[1;32m~\e[1;97m] \e[1;96mPlease Enter Password Length  : \e[0m' length

     read -p $'\e[1;97m[\e[1;32m~\e[1;97m] \e[1;96mPlease Enter Type Of Password : \e[0m' ch

     zip_input && START=$(date +%s)

     for args in "$ch"; do

         case $args in

             a) chars="$chars $chars_1" ;;

             A) chars="$chars $chars_2" ;;

             n) chars="$chars $chars_3" ;;

             c) chars="$chars $chars_4" ;;

         esac;

     done

     for arg in "$ch"; do

         if [ -a $arg ]

         then

             file_name=$arg

             break

         fi

     done

     for w in $chars; do

         word_gen $w

     done

 }

function dictonary()

 {

     clear

     banner

     pswd_input

     zip_input && START=$(date +%s)

     length=`cat $pswd_list | wc -l`

     for ((i=1;i<=$length;i++))

     do

         passwd=`sed -n "$i"p $pswd_list`

         cracker $passwd && echo -e "${WHITE1}[${GREEN1}~${WHITE1}] ${CYAN1}Status         : ${GREEN1}Password Cracked${NC}\n${WHITE1}[${GREEN1}~${WHITE1}] ${CYAN1}Mode           : ${GREEN1}Dictionary${NC}" && flag=$TRUE && exit

     done

 }

function banner()

{

   printf "${GREEN1}

         ███████╗██╗██████╗░██████╗░░█████╗░

         ╚════██║██║██╔══██╗██╔══██╗██╔══██╗

         ░░███╔═╝██║██████╔╝██████╔╝██║░░██║${WHITE1}

         ██╔══╝░░██║██╔═══╝░██╔══██╗██║░░██║

         ███████╗██║██║░░░░░██║░░██║╚█████╔╝

         ╚══════╝╚═╝╚═╝░░░░░╚═╝░░╚═╝░╚════╝░ v_${GREEN1}${version}\n\n"

      printf "${GREEN1}      ╔──────────────────────────────────────╗\n"

      printf "${GREEN1}      |${WHITE1}    c r e a t e d  b y  T æ ñ m æ y   ${GREEN1}|\n"

      printf "${GREEN1}      ╚──────────────────────────────────────╝${NC}\n\n"

}

while :

do

  clear

  banner

function option()

{

  echo -e "${L_RED}${WHITE1}\e[4mSelect Mode\n${NC}"

  echo -e "${GREEN1}[${WHITE1}01${GREEN1}] ${YELLOW1}Brute Force Mode${NC}"

  echo -e "${GREEN1}[${WHITE1}02${GREEN1}]${NC} ${YELLOW1}Dictonary Mode${NC}"

  echo -e "${GREEN1}[${WHITE1}99${GREEN1}]${NC} ${RED1}Exit${NC}"

  echo ""

  read -p $'\e[1;34moption \e[1;97m>>\e[0m ' opt

}

option

if

   [ $opt = 01 ] || [ $opt = 1 ];then

   brute_force

   break

elif

   [ $opt = 02 ] || [ $opt = 2 ];then

   dictonary

   break

elif

   [ $opt = 99 ]; then

   printf "\n" && sleep 0.8 && exit

   break

else printf "\n${CYAN1}[ ${RED1}Error!!⚠️${CYAN1} ] ${RED1}$opt ${CYAN1}is invalid option${NC} \n\n${GREEN1}Try Again...${NC}\n"

 sleep 0.8

fi

done

if [ $flag -eq $FALSE ]

 then

     clear

     banner

     echo -e "${WHITE1}[${RED1}!${WHITE1}] ${RED1}Could Not Found Password ??${NC}"

     echo -e "${WHITE1}[${GREEN1}~${WHITE1}] ${CYAN1}Password Tried : ${CAFE}$counter${NC}"

     echo -e "${WHITE1}[${GREEN1}~${WHITE1}] ${YELLOW1}Please Try Again With Other Keywords...${NC}"

 fi


             
             
             
             
