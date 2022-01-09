#! /bin/bash
#
# [+] By: LawlietJH - BgFill v1.0
#
# [+] Desc: Cambia el fondo de pantalla y agrega persistencia en el archivo 'bspwmrc'.
#
# [+] Usages: bgfill FileName
#
# [+] Examples:
#
#	bgfill FileName
#	bgfill -f FileName

AUTHOR="LawlietJH"
SCRIPT="BgFill"
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
	FILE=$1
	if [[ $1 == "-f" || $1 == "--file" || $1 == "--filename" ]]; then
		FILE=$2
	fi
	#-------------------------------------------------------------------
	pwd=$(pwd)
	if [[ -f "$pwd/$FILE" ]]; then
		sed -i "s|feh --bg-fill .*|feh --bg-fill $(pwd)/$FILE|g" /home/eny/.config/bspwm/bspwmrc
		feh --bg-fill "${pwd}/$FILE"
		echo -e " $OK ${DCY}Nuevo Fondo de Pantalla${NC} -'$FILE'- ($pwd/${CY}$FILE).${NC}" | sed "s|-'|${DCY}'${CY}|g; s|'-|${DCY}'${NC}|g; s|(|${DCY}(${DBL}|g; s|)|${DCY})|g; s|/|${BL}/${DBL}|g"
	else
		echo -e " $ER ${DCY}No Existe el Archivo${NC} -'$FILE'- ($pwd/${CY}$FILE).${NC}" | sed "s|-'|${DCY}'${CY}|g; s|'-|${DCY}'${NC}|g; s|(|${DCY}(${DBL}|g; s|)|${DCY})|g; s|/|${BL}/${DBL}|g"
	fi
elif [[ $1 == "-v" || $1 == "--version" ]]; then
	# Content:
	VER="${GR}By: ${CY}$AUTHOR${NC} - ${CY}$SCRIPT${NC}"
	# Replaces:
	VERSION=$(echo $VERSION | sed "s|v|${DCY}v${CY}|g; s|\.|${DCY}\.${CY}|g")
	VER=$(echo $VER | sed "s|: |${DGR}:${NC} |g; s|-|${DCY}-${NC}|g")
	# Echo:
	echo -e " $OK $VER${NC} $VERSION"
else
	# Content:
	VER="${GR}By: ${CY}$AUTHOR${NC} - ${CY}$SCRIPT${NC}"
	DESC="${GR}Desc: Cambia el fondo de pantalla y agrega persistencia en el archivo -'bspwmrc'-."
	USAGE="${GR}Usage: ${CY}bgfill${NC} [-h|-v] | [-f ${DCY}FileName]"
	OPTIONS="${GR}Options:"
	EXAMPLE="${GR}Examples:"
	# Replaces:
	VERSION=$(echo $VERSION | sed "s|v|${DCY}v${CY}|g; s|\.|${DCY}\.${CY}|g")
	VER=$(echo $VER | sed "s|: |${DGR}:${NC} |g; s|-|${DCY}-${NC}|g")
	DESC=$(echo $DESC | sed "s|: |${DGR}:${NC} ${BL}|g; s|-'|${DCY}'${CY}|g; s|'-|${DCY}'${BL}|g; s|\.|${DCY}\.${BL}|g")
	USAGE=$(echo $USAGE | sed "s| \[| ${DBL}\[${NC}|g; s|]|${DBL}]${NC}|g; s|: |${DGR}:${NC} |g; s|-|${DCY}-${CY}|g; s|\||${DBL}\|${NC}|g")
	OPTIONS=$(echo $OPTIONS | sed "s|:|${DGR}:|g")
	EXAMPLE=$(echo $EXAMPLE | sed "s|:|${DGR}:|g")
	# Echo:
	echo -e " $OK $VER${NC} $VERSION"
	echo
	echo -e " $OK $DESC${NC}"
	echo
	echo -e " $OK $USAGE${NC}"
	echo
	echo -e " $OK $OPTIONS${NC}"
	echo
	echo -e "	-h              ${BL}Muestra este mensaje de ayuda.${NC}" | sed "s|-|${DCY}-${CY}|g"
	echo -e "	-v              ${BL}Muestra la version del script.${NC}" | sed "s|-|${DCY}-${CY}|g"
	echo -e "	-f, --file      ${BL}Selecciona un archivo.${NC}"         | sed "s|-|${DCY}-${CY}|g; s|,|${DCY},${NC}|g"
	echo
	echo -e " $OK $EXAMPLE${NC}"
	echo
	echo -e "	${CY}bgfill${NC} ${DCY}file${NC}        ${BL}Selecciona una imagen para colocar de fondo.${NC}"
	echo -e "	${CY}bgfill${NC} -f ${DCY}file${NC}     ${BL}Selecciona una imagen para colocar de fondo por parametro.${NC}" | sed "s|-|${DCY}-${CY}|g"
fi

echo
