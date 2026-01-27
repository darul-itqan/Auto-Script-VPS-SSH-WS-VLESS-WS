#!/bin/bash
# ====================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : NevermoreSSH
# (C) Copyright 2022
# ====================================
R='\e[1;31m'
P='\e[0;35m'
B='\e[0;36m'
G='\e[0;32m'
N='\e[0m'
red='\e[1;31m'
purple='\e[0;35m'
orange='\e[0;33m'
NC='\e[0m' # No Color
RED='\e[1;91m'
GREEN='\e[38;5;82m'
YELLOW='\e[1;33m'
CYAN='\e[0;36m'
BICyan='\e[1;96m'
BIWhite='\e[1;97m'
HT='\e[38;5;82m'
KS='\e[1;33m' #kuning susu
BYlw='\e[48;5;226m' #yellow backgroud
# Xray-Core Version
xrays_path=$(which xray)
xrays_version=$("$xrays_path" --version 2>&1)
current_version=$(echo "$xrays_version" | awk '/Xray/{print $2}')
# Ambil Xray Core Version Terbaru
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
# Installation Xray Core
xraycore_link="https://github.com/XTLS/Xray-core/releases/download/v$latest_version/Xray-linux-64.zip"
clear
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" | lolcat
echo -e "\e[48;5;226;1;38;5;88m            XRAY CORE VERSION           \e[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" | lolcat
echo -e "${BIWhite}      Current version : ${HT}v${current_version} ${NC}
${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
   [\033[1;36m 1 \033[0m] Xray Core v1.5.4
   [\033[1;36m 2 \033[0m] Xray Core v1.6.1
   [\033[1;36m 3 \033[0m] Xray Core v1.7.2
   [\033[1;36m 4 \033[0m] Xray Core v1.7.5
   [\033[1;36m 5 \033[0m] Xray Core v1.8.4
   [\033[1;36m 6 \033[0m] Xray Core v${latest_version} ${HT}< latest${NC}
${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
   [\033[1;36m 7 \033[0m] Xray Core Mod v1.6.5   
   [\033[1;36m 8 \033[0m] Xray Core Mod v1.7.2-1
   [\033[1;36m 9 \033[0m] Xray Core Mod v25.3.31
${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
  \033[1;36m  10.\033[0m Check Xray Core Version
  \033[1;36m   0.\033[0m Back to main menu"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" | lolcat
echo -e " ✅ Xray Core Mod support custom / multi path."
echo -e " ⚠️ Please reboot your VPS after change the version."
echo -e "${KS} [ Xray Core Changer by NevermoreSSH ]${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" | lolcat
read -p "      Select options from 1–10 : " xcore
echo -e ""
case $xcore in
1)
clear
mv $xrays_path $xrays_path.bakk && wget -q -O $xrays_path "https://github.com/NevermoreSSH/Xcore-custompath/releases/download/Xray-linux-64-v1.5.4/Xray-linux-64-v1.5.4" && chmod 755 $xrays_path && xray version
read -p "$( echo -e "Press ${orange}[ ${NC}${green}Enter${NC} ${CYAN}]${NC} Back to menu . . .") "
xraychanger
;;
2)
clear
mv $xrays_path $xrays_path.bakk && wget -q -O $xrays_path "https://github.com/NevermoreSSH/Xcore-custompath/releases/download/Xray-linux-64-v1.6.1/Xray-linux-64-v1.6.1" && chmod 755 $xrays_path && xray version
read -p "$( echo -e "Press ${orange}[ ${NC}${green}Enter${NC} ${CYAN}]${NC} Back to menu . . .") "
xraychanger
;;
3)
clear
mv $xrays_path $xrays_path.bakk && wget -q -O $xrays_path "https://github.com/NevermoreSSH/Xcore-custompath/releases/download/Xray-linux-64-v1.7.2/Xray-linux-64-v1.7.2" && chmod 755 /usr/local/bin/xray && xray version
read -p "$( echo -e "Press ${orange}[ ${NC}${green}Enter${NC} ${CYAN}]${NC} Back to menu . . .") "
xraychanger
;;
4)
clear
mv $xrays_path $xrays_path.bakk && wget -q -O $xrays_path "https://github.com/NevermoreSSH/Xcore-custompath/releases/download/Xray-linux-64-v1.7.5/Xray-linux-64-v1.7.5" && chmod 755 $xrays_path && xray version
read -p "$( echo -e "Press ${orange}[ ${NC}${green}Enter${NC} ${CYAN}]${NC} Back to menu . . .") "
xraychanger
;;
5)
clear
mv $xrays_path $xrays_path.bakk && wget -q -O $xrays_path "https://github.com/NevermoreSSH/Xcore-custompath/releases/download/Xray-linux-64-v1.8.4/Xray-linux-64-v1.8.4" && chmod 755 $xrays_path && xray version
read -p "$( echo -e "Press ${orange}[ ${NC}${green}Enter${NC} ${CYAN}]${NC} Back to menu . . .") "
xraychanger
;;
6)
clear
mv $xrays_path $xrays_path.bakk && curl -L https://github.com/XTLS/Xray-core/releases/download/v$latest_version/Xray-linux-64.zip > Xray-linux-64.zip && unzip *.zip && mv xray /usr/local/bin && chmod +x $xrays_path && rm *.zip *.dat LICENSE README.md && xray version
mv $xrays_path $xrays_path.bakk && curl -L https://github.com/XTLS/Xray-core/releases/download/v${latest_version}/xray-linux-64.zip > xray-linux-64.zip && unzip *.zip && mv xray /usr/local/bin && chmod +x $xrays_path && rm *.zip *.dat LICENSE README.md && xray version
read -p "$( echo -e "Press ${orange}[ ${NC}${green}Enter${NC} ${CYAN}]${NC} Back to menu . . .") "
xraychanger
;;
7)
clear
mv $xrays_path $xrays_path.bakk && wget -q -O $xrays_path "https://github.com/NevermoreSSH/Xcore-custompath/releases/download/Xray-linux-64-v1.6.5.1/Xray-linux-64-v1.6.5.1" && chmod 755 $xrays_path && xray version
read -p "$( echo -e "Press ${orange}[ ${NC}${green}Enter${NC} ${CYAN}]${NC} Back to menu . . .") "
xraychanger
;;
8)
clear
mv $xrays_path $xrays_path.bakk && wget -q -O $xrays_path "https://github.com/NevermoreSSH/Xcore-custompath/releases/download/Xray-linux-64-v1.7.2-1/Xray-linux-64-v1.7.2-1" && chmod 755 $xrays_path && xray version
read -p "$( echo -e "Press ${orange}[ ${NC}${green}Enter${NC} ${CYAN}]${NC} Back to menu . . .") "
xraychanger
;;
9)
clear
mv $xrays_path $xrays_path.bakk && curl -L https://github.com/NevermoreSSH/Xcore-custompath/releases/download/v25.3.31/Xray-linux-64-v25.3.31.zip > Xray.zip && unzip *.zip && mv xray /usr/local/bin && chmod +x $xrays_path && rm *.zip *.dat LICENSE README.md && xray version
mv $xrays_path $xrays_path.bakk && curl -L https://github.com/XTLS/Xray-core/releases/download/v${latest_version}/xray-linux-64.zip > xray-linux-64.zip && unzip *.zip && mv xray /usr/local/bin && chmod +x $xrays_path && rm *.zip *.dat LICENSE README.md && xray version
read -p "$( echo -e "Press ${orange}[ ${NC}${green}Enter${NC} ${CYAN}]${NC} Back to menu . . .") "
xraychanger
;;
10)
clear
xray version
echo -e "[ ${green}INFO${NC} ] Back to menu in 5 sec . . . "
echo -e "\033[0;32mBack to menu in 5 sec\033[0;32m"
sleep 5
xraychanger
;;
0)
clear
menu
;;
*)
clear
echo -e "[ ${red}INFO${NC} ] Please enter an correct number . . . "
echo -e "\e[1;31m Please enter an correct number\e[1;31m"
sleep 3
xraychanger
;;
esac
