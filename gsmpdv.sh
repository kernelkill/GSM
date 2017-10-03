#!/bin/bash
######################################
#                                    #
#  Menu de acesso ao sistema GSMPDV  #
#  Autor: Elvio Rodrigues            #
#  Empresa: R & Cia Sistemas         #
#                                    #
######################################

#file="/gsmpdv/gsmpdvnew"
#if [ -f "$file" ]
#then %
#	echo ***  A T U A L I Z A N D O  S I S T E M A GSMPDV  ***
#	cd /gsmpdv
#	cp gsmpdv gsmpdv.old
#	cp gsmpdvconfig gsmpdvconfig.old
#	cp envianfce envianfce.old
#	sudo smbclient //192.168.15.50/GSMarket -U guest --pass "" -c "get \versao\gsmpdv /gsmpdv/gsmpdv;"
#	sudo smbclient //192.168.15.50/GSMarket -U guest --pass "" -c "get \versao\gsmpdvconfig /gsmpdv/gsmpdvconfig;"
#	sudo smbclient //192.168.15.50/GSMarket -U guest --pass "" -c "get \versao\envianfce /gsmpdv/envianfce;"
#	sudo chmod 777 -fR /gsmpdv 
#	echo *** ATUALIZACAO OK ***

IP="`hostname -I | cut -f1 -d ' '`"
echo "$IP"
cd /gsmpdv
#startx "/gsmpdv/gsmpdvat" -- :2 vt$(tty | sed -e "s:/dev/tty::")
#startx "/gsmpdv/gsmpdvat" -- :1 
#chvt 2
#pkill gdm
x11vnc -display :0 -forever
#rm ~/.Xauthority
#export DISPLAY=:0.0
#startx "/gsmpdv/gsmpdv" -- :2 vt8
chvt 1
startx "/gsmpdv/gsmpdvat" -- :1
chvt 2
startx "/gsmpdv/gsmpdv" -- :2

while [ opcao != 3 ]; do

  opcao=$(dialog --nocancel --stdout --menu "Menu GSMPDV" \
         0 0 0 1 "Iniciar GSMPDV" \
               2 "Iniciar GSMPDVConfig" \
               3 "Tecnico" \
               4 "Desligar" )

  case $opcao in
    1)  cd /gsmpdv; startx "/gsmpdv/gsmpdv" ;;
    2)  cd /gsmpdv; startx "/gsmpdv/gsmpdvconfig" ;;
    3)  ./tecnico.sh ;;
    4)  poweroff ;;
  255) dialog --msgbox 'Selecione uma das opcoes' 0 0 ;;
  esac
  opcao = 0;

done
