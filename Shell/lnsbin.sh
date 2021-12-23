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

RE="\033[1;31m"
GR="\033[1;32m"
BL="\033[1;34m"
CY="\033[1;36m"
NC="\033[0m"
OK="${CY}[${GR}+${CY}]${NC}"
ER="${BL}[${RE}!${BL}]${NC}"

echo

if [[ $1 != "-h" && $1 != "--help" ]]; then
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
		#--------------------------------------------------------------------------
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
else
	echo -e " $OK ${CY}Usage${BL}:${NC}"
	echo -e "	${CY}lnsbin ${BL}FileName ${GR}CommandName${NC}"
	echo -e "	${CY}lnsbin ${BL}-${CY}f ${BL}FileName ${BL}-${CY}c ${GR}CommandName${NC}"
fi

echo
