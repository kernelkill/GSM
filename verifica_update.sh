#!/bin/bash
#
#
# Nome: verifica_update.sh
#
# Script  criado para atualizar o Sistema automaticamente. 
# Pode ser executado manualmente tambem ou pelo cron, bastando
# apenas copiar para o etc/cron.
# 
# A finalidade do script é para ser executado a cada inicialização
# do sistema, tem uma pasta chamado update dentro do diretorio
# /temp/update, todos as atualizaçoes será colocadas dentro dessa
# pasta manualmente, e toda vez que o sistema iniciar o script será
# lido e feito a atualização.
#
#    ###############################################################
#    ##	Desenvolvido por: Joabe Kachorroski			  			  ##
#    ##	Data: Setembro de 2017					  				  ##
#    ##	Contato: joabejbk@gmail.com / Telegram: @kernelkill	  	  ##
#    ###############################################################
#
# Versão v0.1 24-09-2017
# - Criado a função que verifica se tem atualização dentro da pasta para ser atualizado.
# - Programa não aceita parametros.
# - Adicionando log de sessão
# 
# Versão v0.2 30-09-2017
# - Criado a função de entrar na pasta e realizar backup apenas de alguns arquivos principais.
# 
# OS ARQUIVOS DE ATUALIZAÇOES DEVEM SER COLOCADOS DENTRO DA PASTA /opt/updateGSM.
# A PASTA /opt/backupGSM/ ESTÃO TODOS OS BACKUPS FEITO ANTES DE CADA ATUALIZAÇÃO. 
#		
#    
#
#	AQUI COMEÇA AS VARIAVEIS DE AMBIENTE GLOBAL.

	#Variaveis que vai gerar os logs de sessão e de execução
WORKDIR="/var/log"
SESSION_LOG=${WORKDIR}/$$.log
LOGFILE=${WORKDIR}/verifica_update.log
	#Variavel Data
DATE=`date +%d-%m-%Y`
	# Pasta onde esta as atualizaçoes.
DIR="/opt/updateGSM/"
	# Variavel onde seto o arquivo de referencia.
FILE="gsmpdv"
	# Pasta que iremos pegar os arquivos ataulizados.
FILENAME="GSMPDV-$DATE.tar.gz"
	#Pasta que sera feito backup.
DIRBKPSRC="/gsmpdv"
DIRBKP="/gsmpdv/backup/"
	#Pasta onde será guardado o backup da pasta GSMPDV.
DIRBKPDST="/opt/backupGSM/"
#
#
#    AQUI ENCERRA A DECLARAÇÃO DAS VARIAVEIS
#

	#Funcão para gerar log com data e com o processo.
function LOG(){
 DATA=$(date +"%d-%m-%Y")
 echo ${DATA} $1 | tee -a ${SESSION_LOG}
}

	#init
	#Procura por atualizações a serem instaladas
if [ -e $DIR$FILE ]; then
	
	LOG "Existe atualização dentro de $DIR a ser instalada[...]"
	sleep 5
	LOG "Realizando Backup dos arquivos do GSMPDV...[ AGUARDE ]"
	sleep 5
	cd $DIRBKPSRC
	mkdir $DIRBKP
	cp gsmpdv gsmpdvat gsmpdvconfig envianfce gsmpdv.fdb $DIRBKP
	tar -cvpzf $DIRBKPDST/$FILENAME $DIRBKP
	rm -Rf $DIRBKP
	if [ $? -eq '0' ]; then
		LOG "Backup Realizado com Sucesso, iremos começar a atualização...[ AGUARDE ]"
		sleep 5
		LOG "Realizando atualização do GSMPDV...[ AGUARDE ]"
		cd $DIR
		cp gsmpdv gsmpdvat gsmpdvconfig envianfce gsmpdv.fdb $DIRBKPSRC
		LOG "GSMPDV atualizado...[ OK ]"
		sleep 5
		LOG "Limpando pasta de atualização...[ OK ]"
		rm $DIR/*
		LOG "Limpeza comcluida com Sucesso...[ SUCESSO ] "	
	elif [ $? -ne '0' ]; then
		LOG "O Backup não foi realizado, encerrando programa...[ WARNING ]"
		exit 1
	fi	
else
	LOG  "$DIR Não tem atualização"
	exit 1
fi

#Salva o log da sessão no log geral
cat ${SESSION_LOG} >> ${LOGFILE}
