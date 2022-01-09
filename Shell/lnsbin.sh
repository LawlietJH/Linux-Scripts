#! /bin/bash
#
# [+] By: LawlietJH - lnsbin v1.0
#
# [+] Desc: Crea un link en la ruta /usr/bin de un archivo,
#           permitiendo ejecutarlo directamente como comando.
#
# [+] Usage:
#	lnsbin FileName CommandName
#	lnsbin -f FileName -c CommandName

AUTHOR="LawlietJH"
SCRIPT="Lnsbin"
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
		FILE=""
		NAME=""
		if [[ $1 == "-f" || $1 == "--file" || $1 == "--filename" ]] && [[ -n $2 ]] && [[ $3 == "-c" || $3 == "--command" || $3 == "--commandname" ]] && [[ -n $4 ]]; then
			FILE=$2
			NAME=$4
		elif [[ $1 == "-c" || $1 == "--command" || $1 == "--commandname" ]] && [[ -n $2 ]] && [[ $3 == "-f" || $3 == "--file" || $3 == "--filename" ]] && [[ -n $4 ]]; then
			FILE=$4
			NAME=$2
		else
			if [[ -n $1 && -n $2 ]]; then
				FILE=$1
				NAME=$2
			fi
		fi
		#---------------------------------------------------------------
		if [[ -f $FILE && -n $NAME ]]; then
			if [[ -f /usr/bin/$NAME ]]; then
				echo -e " $ER Ya existe un comando con el nombre ${CY}'$NAME'${NC}."
			else
				ln -s $(pwd)/$FILE /usr/bin/$NAME
				echo -e " $OK El commando '${CY}$NAME${NC}' ⇒ ${BL}$(pwd)/${CY}$FILE${NC}"
				echo -e "     Ha sido creado con exito."
			fi
		else
			echo -e " $OK ${CY}Usage${BL}:${NC}"
			echo -e "	${CY}lnsbin ${BL}FileName ${GR}CommandName${NC}"
			echo -e "	${CY}lnsbin ${BL}-${CY}f ${BL}FileName ${BL}-${CY}c ${GR}CommandName${NC}"
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
	DESC="${GR}Desc: Crea un link de un archivo en la ruta -'/usr/bin'- permitiendo ejecutarlo directamente como comando."
	USAGE="${GR}Usage: ${CY}lnsbin${NC} [-h|-v] | [-f ${DCY}Filename${NC}] [-c ${DCY}CommandName${NC}]"
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
	echo -e "	-h               ${BL}Muestra este mensaje de ayuda.${NC}"   | sed "s|-|${DCY}-${CY}|g"
	echo -e "	-v               ${BL}Muestra la version del script.${NC}"   | sed "s|-|${DCY}-${CY}|g"
	echo -e "	-f, --file       ${BL}Selecciona un archivo.${NC}"           | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo -e "	-c, --command    ${BL}Selecciona un nombre de comando.${NC}" | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo
	echo -e " $OK $EXAMPLE${NC}"
	echo
	echo -e "	${CY}lnsbin${NC} ${DCY}file${NC} ${DBL}command${NC}          ${BL}Selecciona un archivo para crear el comando y se le coloca un nombre.${NC}"
	echo -e "	${CY}lnsbin${NC} -f ${DCY}file${NC} -c ${DBL}command${NC}    ${BL}Selecciona un archivo para crear el comando y se le coloca un nombre por parametros.${NC}" | sed "s|-|${DCY}-${CY}|g"
fi

echo
