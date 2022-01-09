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

AUTHOR="LawlietJH"
SCRIPT="SMBServer"
VERSION="v1.0"
DGR="\x1b[0;32m"
DBL="\x1b[0;34m"
DCY="\x1b[0;36m"
RE="\x1b[1;31m"
GR="\x1b[1;32m"
BL="\x1b[1;34m"
CY="\x1b[1;36m"
NC="\x1b[0m"
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
	VER="${GR}By: ${CY}$AUTHOR${NC} - ${CY}$SCRIPT${NC}"
	VERSION=$(echo $VERSION | sed "s|v|${DCY}v${CY}|g; s|\.|${DCY}\.${CY}|g")
	VER=$(echo $VER | sed "s|: |${DGR}:${NC} |g; s|-|${DCY}-${NC}|g")
	echo -e " $OK $VER${NC} $VERSION"
else
	# Content:
	VER="${GR}By: ${CY}$AUTHOR${NC} - ${CY}$SCRIPT${NC}"
	DESC="${GR}Desc: Inicia un recurso compartido en red por ${DCY}SMB${NC}."
	USAGE="${GR}Usage: ${CY}smbserver${NC} [-h|-v] | [-u ${DCY}UserName${NC}] [-p ${DCY}Password${NC}]"
	OPTIONS="${GR}Options:"
	EXAMPLE="${GR}Examples:"
	# Replaces:
	VERSION=$(echo $VERSION | sed "s|v|${DCY}v${CY}|g; s|\.|${DCY}\.${CY}|g")
	VER=$(echo $VER | sed "s|: |${DGR}:${NC} |g; s|-|${DCY}-${NC}|g")
	DESC=$(echo $DESC | sed "s|: |${DGR}:${NC} ${BL}|g; s|-'|${DCY}'${CY}|g; s|'-|${DCY}'${BL}|g; s|\.|${DCY}\.${BL}|g")
	USAGE=$(echo $USAGE | sed "s| \[| ${DBL}\[${NC}|g; s|]|${DBL}]${NC}|g; s|: |${DGR}:${NC} |g; s|-|${DCY}-${CY}|g; s|\||${DBL}\|${NC}|g")
	OPTIONS=$(echo $OPTIONS | sed "s|:|${DGR}:|g")
	EXAMPLE=$(echo $EXAMPLE | sed "s|:|${DGR}:|g")
	# Print:
	echo -e " $OK $VER${NC} $VERSION"
	echo
	echo -e " $OK $DESC${NC}"
	echo
	echo -e " $OK $USAGE${NC}"
	echo
	echo -e " $OK $OPTIONS${NC}"
	echo
	echo -e "	-h              ${BL}Muestra este mensaje de ayuda.${NC}"   | sed "s|-|${DCY}-${CY}|g"
	echo -e "	-v              ${BL}Muestra la version del script.${NC}"   | sed "s|-|${DCY}-${CY}|g"
	echo -e "	-u, --user      ${BL}Selecciona un nombre de usuario.${NC}" | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo -e "	-p, --passwd    ${BL}Selecciona una contraseña.${NC}"       | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo
	echo -e " $OK $EXAMPLE${NC}"
	echo
	echo -e "	${CY}smbserver${NC}                      ${BL}Inicia el servicio.${NC}"
	echo -e "	${CY}smbserver${NC} ${DCY}user${NC}                 ${BL}Inicia el servicio con usuario sin contraseña.${NC}"
	echo -e "	${CY}smbserver${NC} ${DCY}user${NC} ${DBL}passwd${NC}          ${BL}Indica el servicio con usuario y contraseña.${NC}"
	echo -e "	${CY}smbserver${NC} -u ${DCY}user${NC} -p ${DBL}passwd${NC}    ${BL}Indica el servicio con usuario y contraseña por parametros.${NC}" | sed "s|-|${DCY}-${CY}|g"
fi

echo
