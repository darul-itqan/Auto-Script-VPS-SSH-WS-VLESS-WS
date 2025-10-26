# Auto script VPS
## SSH WebSocket & VLESS WebSocket
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
