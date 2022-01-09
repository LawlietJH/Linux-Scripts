#! /bin/bash
#
# [+] By: LawlietJH - ChData v1.0
#
# [+] Desc: Cambia el propietario y grupo de uno o varios archivos.
#
# [+] Usages:
#
#	chdata UserName FileName
#	chdata -u UserName -f FileName

function setUser() {
	#chmod +x ${@:2}
	chown -R $1 ${@:2}
	chgrp -R $1 ${@:2}
	for val in ${@:2}
	do
		echo -e " $OK Nuevo propietario del archivo '${GR}$val${NC}': ${CY}$1${NC}"
	done
}

AUTHOR="LawlietJH"
SCRIPT="ChData"
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
		FILE=""
		if [[ $1 == "-u" || $1 == "--user" || $1 == "--username" ]] && [[ -n $2 ]] && [[ $3 == "-f" || $3 == "--file" || $3 == "--filename" ]] && [[ -n $4 ]]; then
			USER=$2
			FILE=${@:4}
		elif [[ $1 == "-f" || $1 == "--file" || $1 == "--filename" ]] && [[ -n $2 ]] && [[ $3 == "-u" || $1 == "--user" || $1 == "--username" ]] && [[ -n $4 ]]; then
			USER=$4
			FILE=$2
		else
			if [[ -n $(grep $1 /etc/passwd) && -n $2 ]]; then
				USER=$1
				FILE=${@:2}
			elif [[ -n $1 && -n $(grep $2 /etc/passwd) ]]; then
				USER=$2
				FILE=$1
			fi
		fi
		#---------------------------------------------------------------
		if [[ -n $(grep $USER /etc/passwd) ]]; then
			if [[ -f $FILE ]]; then
				setUser $USER $FILE
			else
				echo " $ER El Archivo ${CY}'$FILE'${NC} No existe."
			fi
		else
			echo " $ER El Usuario ${CY}'$USER'${NC} No existe."
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
	DESC="${GR}Desc: Cambia el propietario y grupo de uno o varios archivos."
	USAGE="${GR}Usage: ${CY}chdata${NC} [-h|-v] | [-u ${DCY}UserName${NC}] [-f ${DCY}FileName${NC}]"
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
	echo -e "	-h              ${BL}Muestra este mensaje de ayuda.${NC}"   | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo -e "	-v              ${BL}Muestra la version del script.${NC}"   | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo -e "	-u, --user      ${BL}Selecciona un nombre de usuario.${NC}" | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo -e "	-f, --file      ${BL}Selecciona un archivo.${NC}"           | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo
	echo -e " $OK $EXAMPLE${NC}"
	echo
	echo -e "	${CY}chdata ${DCY}username${NC} ${DCY}filename${NC}          ${BL}Cambia el propietario y grupo de uno o varios archivos.${NC}"
	echo -e "	${CY}chdata -u ${DCY}username${NC} -f ${DCY}filename${NC}    ${BL}Cambia el propietario y grupo de uno o varios archivos.${NC}" | sed "s|-|${DCY}-${CY}|g"
fi

echo
