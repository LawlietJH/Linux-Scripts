#! /bin/bash
#
# [+] By: LawlietJH - DumpSAM v1.0
#
# [+] Desc: Extrae los hashes del archivo SAM de Windows.
#
# [+] Dependencias: Impacket-SecretsDump
#
# [+] Usages:
#
#	dumpsam SAM SYSTEM

AUTHOR="LawlietJH"
SCRIPT="DumpSAM"
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
	SAM=""
	SYS=""
	if [[ -n $1 && -n $2 ]]; then
		SAM=$1
		SYS=$2
	fi
	#-------------------------------------------------------------------
	if [[ -f $SAM ]]; then
		if [[ -f $SYS ]]; then
			impacket-secretsdump -sam $SAM -system $SYS LOCAL
		else
			echo -e " $ER El Archivo ${CY}'$SYS'${NC} No existe."
		fi
	else
		echo -e " $ER El Archivo ${CY}'$SAM'${NC} No existe."
	fi
elif [[ $1 == "-v" || $1 == "--version" ]]; then
	VER="${GR}By: ${CY}$AUTHOR${NC} - ${CY}$SCRIPT${NC}"
	VERSION=$(echo $VERSION | sed "s|v|${DCY}v${CY}|g; s|\.|${DCY}\.${CY}|g")
	VER=$(echo $VER | sed "s|: |${DGR}:${NC} |g; s|-|${DCY}-${NC}|g")
	echo -e " $OK $VER${NC} $VERSION"
else
	# Content:
	VER="${GR}By: ${CY}$AUTHOR${NC} - ${CY}$SCRIPT${NC}"
	DESC="${GR}Desc: Extrae los hashes del archivo ${DCY}SAM${BL} de Windows."
	USAGE="${GR}Usage: ${CY}dumpsam${NC} [-h|-v] | [${DCY}SAM_File SYSTEM_File${NC}]"
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
	echo -e "	-h              ${BL}Muestra este mensaje de ayuda.${NC}" | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo -e "	-v              ${BL}Muestra la version del script.${NC}" | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo
	echo -e " $OK $EXAMPLE${NC}"
	echo
	echo -e "	${CY}dumpsam ${DCY}SAM${NC} ${DCY}SYSTEM${NC}    ${BL}Extrae los hashes del archivo ${DCY}SAM${BL}.${NC}"
fi

echo
