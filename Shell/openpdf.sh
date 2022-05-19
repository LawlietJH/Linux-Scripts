#! /bin/bash
#
# [+] By: LawlietJH - OpenPDF v1.1
#
# [+] Desc: Abre un PDF de forma segura con FireJail.
#
# [+] Usages:
#
#	openpdf FileName.pdf

function openpdf() {
	# Constantes para almacenar los Parametros
	FILE=""
	FULL=false
	OPEN=false
	INSC=false
	SHIFTED=()
	# Extraccion de Parametros
	while [[ $# -gt 0 ]]; do
		case $1 in
			-f|--full|--fullscreen) FULL=true; shift;;
			-o|--open)              OPEN=true; shift;;
			-i|--insecure)          INSC=true; shift;;
			*) SHIFTED+=("$1"); shift;;
		esac
	done
	FILE=${SHIFTED[0]}
	#-------------------------------------------------------------------
	if [[ -f $FILE ]]; then
		if [[ $FULL == true ]]; then
			echo -e " $OK Command: firejail --quiet firefox _'$FILE'_${NC} --kiosk" | sed "s|_'|${DCY}'${CY}|g; s|'_|${DCY}'${BL}|g"
			echo
			firejail --quiet firefox "$FILE" --kiosk
		elif [[ $OPEN == true ]]; then
			echo -e " $OK Command: open _'$FILE'_${NC}" | sed "s|_'|${DCY}'${CY}|g; s|'_|${DCY}'${BL}|g"
			echo
			open "$FILE"
		elif [[ $INSC == true ]]; then
			echo -e " $OK Command: firefox _'$FILE'_${NC}" | sed "s|_'|${DCY}'${CY}|g; s|'_|${DCY}'${BL}|g"
			echo
			firefox "$FILE"
		else
			echo -e " $OK Command: firejail --quiet firefox _'$FILE'_${NC}" | sed "s|_'|${DCY}'${CY}|g; s|'_|${DCY}'${BL}|g"
			echo
			firejail --quiet firefox "$FILE"
		fi
	else
		echo -e " $ER El Archivo ${CY}'$FILE'${NC} No existe."
		help
	fi
}

function help() {
	# Content:
	VER="${GR}By: ${CY}$AUTHOR${NC} - ${CY}$SCRIPT${NC}"
	DESC="${GR}Desc: Abre un ${DCY}PDF${BL} de forma segura con ${DCY}FireJail${BL}."
	USAGE="${GR}Usage: ${CY}openpdf${NC} [-h|-v] | [${DCY}FileName.pdf${NC}] [-f|-i|-o]"
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
	echo -e "	-h                ${BL}Muestra este mensaje de ayuda.${NC}"               | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo -e "	-v                ${BL}Muestra la version del script.${NC}"               | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo -e "	-f, --full        ${BL}Abre el pdf en pantalla completa.${NC}"            | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo -e "	-i, --insecure    ${BL}Abre el pdf sin _'firejail'_.${NC}"                | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g; s|_'|${DCY}'${CY}|g; s|'_|${DCY}'${BL}|g"
	echo -e "	-o, --open        ${BL}Abre el pdf con _'open'_ y sin _'firejail'_.${NC}" | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g; s|_'|${DCY}'${CY}|g; s|'_|${DCY}'${BL}|g"
	echo
	echo -e " $OK $EXAMPLE${NC}"
	echo
	echo -e "	${CY}openpdf ${DCY}FileName.pdf${NC}       ${BL}Abre un ${DCY}PDF${BL} de forma segura con ${DCY}FireJail${BL}.${NC}"
	echo -e "	${CY}openpdf -f ${DCY}FileName.pdf${NC}    ${BL}Abre en Pantalla Completa de Forma segura con ${DCY}FireJail${BL}.${NC}" | sed "s|-|${DCY}-${CY}|g"
	echo -e "	${CY}openpdf -i ${DCY}FileName.pdf${NC}    ${BL}Abre de forma insegura.${NC}"                                            | sed "s|-|${DCY}-${CY}|g"
	echo -e "	${CY}openpdf -o ${DCY}FileName.pdf${NC}    ${BL}Abre con ${DCY}Open${BL}.${NC}"                                          | sed "s|-|${DCY}-${CY}|g"
} 

AUTHOR="LawlietJH"
SCRIPT="OpenPDF"
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
	openpdf "$@"
elif [[ $1 == "-v" || $1 == "--version" ]]; then
	VER="${GR}By: ${CY}$AUTHOR${NC} - ${CY}$SCRIPT${NC}"
	VERSION=$(echo $VERSION | sed "s|v|${DCY}v${CY}|g; s|\.|${DCY}\.${CY}|g")
	VER=$(echo $VER | sed "s|: |${DGR}:${NC} |g; s|-|${DCY}-${NC}|g")
	echo -e " $OK $VER${NC} $VERSION"
else
	help
fi

echo
