#! /bin/bash
#
# [+] By: LawlietJH - OpenPDF v1.0
#
# [+] Desc: Abre un PDF de forma segura con FireJail.
#
# [+] Usages:
#
#	openpdf FileName.pdf

function openpdf() {
	FULL=0
	OPEN=0
	INSC=0
	#-------------------------------------------------------------------
	# Delete simple parameters
	params=("$@")
	new_params=()
	pos=0
	for i in "${!params[@]}"
	do
		val=${params[$i]}
		if [[ $val == "-f" || $val == "--full" || $val == "--fullscreen" ]]; then
			FULL=1
		elif [[ $val == "-o" || $val == "--open" ]]; then
			OPEN=1
		elif [[ $val == "-i" || $val == "--insecure" ]]; then
			INSC=1
		else
			new_params[$pos]=$val
			((pos++))
		fi
	done
	params=("${new_params[@]}")
	#-------------------------------------------------------------------
	# Analyze other parameters
	PDF=""
	[[ -f ${params[0]} ]] && PDF=${params[0]}
	#-------------------------------------------------------------------
	if [[ -f $PDF ]]; then
		if [[ $FULL == 1 ]]; then
			firejail firefox "$PDF" --kiosk
		elif [[ $OPEN == 1 ]]; then
			open "$PDF"
		elif [[ $INSC == 1 ]]; then
			firefox "$PDF"
		else
			firejail firefox "$PDF"
		fi
	else
		echo -e " $ER El Archivo ${CY}'$PDF'${NC} No existe."
	fi
}

AUTHOR="LawlietJH"
SCRIPT="OpenPDF"
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
	openpdf "$@"
elif [[ $1 == "-v" || $1 == "--version" ]]; then
	VER="${GR}By: ${CY}$AUTHOR${NC} - ${CY}$SCRIPT${NC}"
	VERSION=$(echo $VERSION | sed "s|v|${DCY}v${CY}|g; s|\.|${DCY}\.${CY}|g")
	VER=$(echo $VER | sed "s|: |${DGR}:${NC} |g; s|-|${DCY}-${NC}|g")
	echo -e " $OK $VER${NC} $VERSION"
else
	# Content:
	VER="${GR}By: ${CY}$AUTHOR${NC} - ${CY}$SCRIPT${NC}"
	DESC="${GR}Desc: Abre un ${DCY}PDF${BL} de forma segura con ${DCY}FireJail${BL}."
	USAGE="${GR}Usage: ${CY}openpdf${NC} [-h|-v] | [-f|-i|-o] [${DCY}FileName.pdf${NC}]"
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
fi

echo
