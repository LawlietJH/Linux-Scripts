#! /bin/bash
#
# [+] By: LawlietJH - lnsbin v1.1
#
# [+] Desc: Crea un link en la ruta /usr/bin de un archivo,
#           permitiendo ejecutarlo directamente como comando.
#
# [+] Usage:
#	lnsbin FileName CommandName
#	lnsbin -f FileName -c CommandName
#	lnsbin -f FileName -c CommandName -l
#	lnsbin -f FileName -c CommandName -r
#	lnsbin FileName CommandName -l -r

AUTHOR="LawlietJH"
SCRIPT="Lnsbin"
VERSION="v1.1"
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
		# Constantes para almacenar los Parametros
		FILE=""
		COMMAND=""
		LOCAL=false
		REPLACE=false
		SHIFTED=()
		# Extraccion de Parametros
		while [[ $# -gt 0 ]]; do
			case $1 in
				-f|--file)    FILE=$2;      shift; shift;;
				-c|--command) COMMAND=$2;   shift; shift;;
				-l|--local)   LOCAL=true;   shift;;
				-r|--replace) REPLACE=true; shift;;
				*) SHIFTED+=("$1"); shift;;
			esac
		done
		if [[ -z $FILE && -z $COMMAND ]]; then
			FILE=${SHIFTED[0]}
			COMMAND=${SHIFTED[1]}
		fi
		#---------------------------------------------------------------
		if [[ -f $FILE && -n $COMMAND ]]; then
			if [[ -f /usr/bin/$COMMAND ]]; then
				echo -e " $ER Ya existe un comando con el nombre ${CY}'$COMMAND'${NC}."
			else
				if   [[ $LOCAL == true  && $REPLACE == true  ]]; then ln -sf $(pwd)/$FILE /usr/local/bin/$COMMAND
				elif [[ $LOCAL == true  && $REPLACE == false ]]; then ln -s  $(pwd)/$FILE /usr/local/bin/$COMMAND
				elif [[ $LOCAL == false && $REPLACE == true  ]]; then ln -sf $(pwd)/$FILE /usr/bin/$COMMAND
				elif [[ $LOCAL == false && $REPLACE == false ]]; then ln -s  $(pwd)/$FILE /usr/bin/$COMMAND
				fi
				echo -e " $OK El commando '${CY}$COMMAND${NC}' ⇒ ${BL}$(pwd)/${CY}$FILE${NC}"
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
	USAGE="${GR}Usage: ${CY}lnsbin${NC} [-h|-v] | [-f ${DCY}Filename${NC} -c ${DCY}CommandName${NC}] [-l] [-r]"
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
	echo -e "	-h               ${BL}Muestra este mensaje de ayuda.${NC}"                                     | sed "s|-|${DCY}-${CY}|g"
	echo -e "	-v               ${BL}Muestra la version del script.${NC}"                                     | sed "s|-|${DCY}-${CY}|g"
	echo -e "	-f, --file       ${BL}Selecciona un archivo.${NC}"                                             | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo -e "	-c, --command    ${BL}Selecciona un nombre de comando.${NC}"                                   | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo -e "	-l, --local      ${BL}Selecciona la carpeta -'/usr/local/bin'- en lugar de -'/usr/bin'-.${NC}" | sed "s|: |${DGR}:${NC} ${BL}|g; s|-'|${DCY}'${CY}|g; s|'-|${DCY}'${BL}|g; s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo -e "	-r, --remote     ${BL}Si ya existe el enlace lo remplaza.${NC}"                                | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo
	echo -e " $OK $EXAMPLE${NC}"
	echo
	echo -e "	${CY}lnsbin${NC} ${DCY}file${NC} ${DBL}command${NC}            ${BL}Selecciona un archivo para crear el comando.${NC}"
	echo -e "	${CY}lnsbin${NC} -f ${DCY}file${NC} -c ${DBL}command${NC}      ${BL}Selecciona un archivo para crear el comando.${NC}"                               | sed "s|-|${DCY}-${CY}|g"
	echo -e "	${CY}lnsbin${NC} -f ${DCY}file${NC} -c ${DBL}command${NC} -l   ${BL}Selecciona un archivo para crear el comando alojado en -'/usr/local/bin'-.${NC}" | sed "s|-'|${DCY}'${CY}|g; s|'-|${DCY}'${BL}|g; s|-|${DCY}-${CY}|g"
	echo -e "	${CY}lnsbin${NC} -f ${DCY}file${NC} -c ${DBL}command${NC} -r   ${BL}Selecciona un archivo para crear el comando y lo remplaza si ya existe.${NC}"    | sed "s|-|${DCY}-${CY}|g"
	echo -e "	${CY}lnsbin${NC} ${DCY}file${NC} ${DBL}command${NC} -l -r" | sed "s|-|${DCY}-${CY}|g"
fi

echo
