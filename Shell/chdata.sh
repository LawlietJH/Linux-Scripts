#! /bin/bash
#
# [+] By: LawlietJH - chdata v1.0
#
# [+] Desc: Cambia el propietario y grupo de uno o varios archivos.
#
# [+] Usages:
#	chdata UserName FileName
#	chdata -u UserName -f FileName

function setUser () {
	#chmod +x ${@:2}
	chown -R $1 ${@:2}
	chgrp -R $1 ${@:2}
	for val in ${@:2}
	do
		echo -e " $OK Nuevo propietario del archivo '${GR}$val${NC}': ${CY}$1${NC}"
	done
}

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
		echo " $ER Necesitas Permisos de administrador..."
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
		#--------------------------------------------------------------------------
		if [[ -n $USER && -n $FILE ]]; then
			if [[ -n $(grep $USER /etc/passwd) ]]; then
				setUser $USER $FILE
			else
				echo " $ER El Usuario ${CY}'$USER'${NC} No existe."
			fi
		else
			echo -e " $OK ${CY}Usage${BL}:${NC}"
			echo -e "	${CY}chdata ${BL}UserName ${GR}FileName${NC}"
			echo -e "	${CY}chdata ${BL}-${CY}u ${BL}UserName ${BL}-${CY}f ${GR}FileName${NC}"
		fi
	fi
else
	# Help
	echo -e " $OK ${CY}Usage${BL}:${NC}"
	echo -e "	${CY}chdata ${BL}UserName ${GR}FileName${NC}"
	echo -e "	${CY}chdata ${BL}-${CY}u ${BL}UserName ${BL}-${CY}f ${GR}FileName${NC}"
fi

echo
