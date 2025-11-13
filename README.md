# DarQan Auto script VPS - SSH WebSocket & VLESS WebSocket
## for Debian 11 & 12

## Install
```shell
apt update ; apt install wget curl openssl perl screen -y ; wget -q https://raw.githubusercontent.com/darul-itqan/Auto-Script-VPS-SSH-WS-VLESS-WS/main/install.sh ; chmod +x install.sh ; screen -S rere ./install.sh; if [ $? -ne 0 ]; then rm -f install.sh; fi
```

## Note
If disconnect in installation process, just relogin and copy-paste this command
```shell
screen -r rere
```

## Features & Options DarQan Auto Script
1. Hanya protocol SSH WS & VLESS WS sahaja.
2. Custom UUID.
3. Custom path (VLESS).
4. Limit IP setiap user (had device login).
5. Limit data (GB) setiap user.
6. Check online user.
7. Auto delete multi login user.
8. Auto delete expired account.
9. Boleh recovery expired & deleted account.
10. Xray Core Changer by NevermoreSSH.
11. BBR Plus & performance tweak.
12. Auto swap RAM 4GB.
13. Auto reboot jam 5:00AM setiap hari.
14. Auto clean log & cache setiap minggu.
