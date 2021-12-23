#! /bin/bash
#
# [+] By: LawlietJH - SMBServer v1.0
#
# [+] Desc: Comparte en red la carpeta actual.
#
#	- Ejemplo de como conectarse desde Windows al recurso compartido:
#	    net use \\IP								# Se conecta al recurso compartido
#	    net use \\IP /user:UserName Password		# El user y password son necesarios solo si se indicaron desde smbserver
#	    copy file.ext \\IP\smbFolder\				# Manda un archivo
#	    copy * \\IP\smbFolder\						# Manda todos los archivos de la carpeta actual
#	    copy \\IP\smbFolder\file.ext .				# Obtiene un archivo en la ruta actual
#	    copy \\IP\smbFolder\* .						# Obtiene todos los archivos de la carpeta y los coloca en la ruta actual
#		xcopy \\IP\smbFolder\folder . /E /H /C /I	# Obtiene el contenido de un directorio completo
#		net use * /delete							# Cierra las conexiones existentes
#
# [+] Usages:
#	smbserver
#	smbserver UserName
#	smbserver UserName Password
#	smbserver -u UserName
#	smbserver -u UserName -p Password

SCRIPT="SMBServer"
VERSION="1.0"
DGR="\033[0;32m"
DBL="\033[0;34m"
DCY="\033[0;36m"
RE="\033[1;31m"
GR="\033[1;32m"
BL="\033[1;34m"
CY="\033[1;36m"
NC="\033[0m"
OK="${CY}[${GR}+${CY}]${NC}"
ER="${BL}[${RE}!${BL}]${NC}"

echo

if [[ $1 != "-h" && $1 != "--help" && $1 != "-v" && $1 != "--version" ]]; then
	if [[ $EUID == "1000" ]]; then
		echo -e " $ER Necesitas Permisos de administrador..."
	else
		USER=""
		PASS=""
		if [[ -n $1 ]]; then
			if [[ $1 == "-u" || $1 == "--user" || $1 == "--username" ]] && [[ -n $2 ]]; then
				if [[ $3 == "-p" || $3 == "--passwd" || $3 == "--password" ]] && [[ -n $4 ]]; then
					USER=$2
					PASS=$4
				else
					USER=$2
				fi
			elif [[ $1 == "-p" || $1 == "--passwd" || $1 == "--password" ]] && [[ -n $2 ]]; then
				if [[ $3 == "-u" || $3 == "--user" || $3 == "--username" ]] && [[ -n $4 ]]; then
					USER=$4
					PASS=$2
				fi
			else
				if [[ -n $2 && -z $3 ]]; then
					USER=$1
					PASS=$2
				else
					USER=$1
				fi
			fi
		fi
		#--------------------------------------------------------------------------
		echo -e "${BL}--------------------------------${NC}"
		echo -e " ${BL}*${GR}IP${BL}: ${CY}$(hostname -I | sed -e 's/ /, /g' | rev | cut -c 3- | rev)${NC}"
		echo -e " ${BL}*${GR}Username${BL}: ${CY}$USER${NC}"
		echo -e " ${BL}*${GR}Password${BL}: ${CY}$PASS${NC}"
		echo -e "${BL}--------------------------------${NC}"
		echo
		#--------------------------------------------------------------------------
		if [[ -n $USER && -n $PASS ]]; then
			impacket-smbserver smbFolder $(pwd) -smb2support -username $USER -password $PASS
		elif [[ -n $USER && -z $PASS ]]; then
			impacket-smbserver smbFolder $(pwd) -smb2support -username $USER -password ''
		else
			impacket-smbserver smbFolder $(pwd) -smb2support
		fi
	fi
elif [[ $1 == "-v" || $1 == "--version" ]]; then
	echo -e " $OK ${CY}$SCRIPT ${BL}v${CY}$VERSION${NC}"
else
	# Banner SMBServer
	# SMBServer v1.0: Inicia un recurso compartido en red.
	# By: LawlietJH
	#
	# Usage: smbserver [-h|-v] | [-u username] [-p password]
	#
	# Options:
	#     -h    Show this help message
	#     -v    Show script version
	#     -u    Set Username
	#     -p    Set Password
	#
	# Examples: 
	#   smbserver                     Inicia el servicio
	#   smbserver user                Inicia el servicio con usuario sin contraseña
	#   smbserver user passwd         Indica el servicio con usuario y contraseña
	#   smbserver -u user -p passwd   Indica el servicio con usuario y contraseña por parametros
	# Help
	#~ echo -e " $OK ${CY}$SCRIPT ${DCY}v${CY}1${DCY}.${CY}0${NC}"
	#~ echo
	nDCY="\x1b[0;36m"
	nCY="\x1b[1;36m"
	VER=$(echo $VERSION | sed "s|\.|${nDCY}\.${nCY}|g")
	echo -e " $OK ${CY}$SCRIPT ${DCY}v${CY}$VER${NC}"
	echo
	echo -e " $OK ${GR}Usage${DGR}:${NC} ${CY}smbserver${NC} ${DBL}[${DCY}-${CY}h${NC}${DBL}|${DCY}-${CY}v${DBL}]${NC} ${DBL}|${NC} ${DBL}[${DCY}-${CY}u${NC} ${DCY}username${DBL}]${NC} ${DBL}[${DCY}-${CY}p${NC} ${DCY}password${DBL}]${NC}"
	echo
	echo -e " $OK ${GR}Examples${DGR}:${NC}"
	echo -e "	${CY}smbserver${NC}"
	echo -e "	${CY}smbserver ${DCY}UserName${NC}"
	echo -e "	${CY}smbserver ${DCY}UserName ${BL}Password${NC}"
	echo -e "	${CY}smbserver ${DCY}-${CY}u ${DCY}UserName${NC}"
	echo -e "	${CY}smbserver ${DCY}-${CY}u ${DCY}UserName ${DCY}-${CY}p ${BL}Password${NC}"
fi

echo
