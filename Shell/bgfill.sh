#! /bin/bash
#
# [+] By: LawlietJH - BgFill v1.0
#
# [+] Desc: Cambia el fondo de pantalla y agrega persistencia en el archivo 'bspwmrc'.
#
# [+] Usages:
#	bgfill FileName

SCRIPT="BgFll"
VERSION="1.0"
DGR="\033[0;32m"
DBL="\033[0;34m"
DCY="\033[0;36m"
RE="\033[1;31m"
GR="\033[1;32m"
BL="\033[1;34m"
CY="\033[1;36m"
NC="\033[0m"
OK="${CY}[${GR}+${CY}]${NC}"
ER="${BL}[${RE}!${BL}]${NC}"

echo

if [[ $1 != "-h" && $1 != "--help" ]]; then
	if [[ -f "$(pwd)/$1" ]]; then
		pwd=$(pwd)
		sed -i "s|feh --bg-fill .*|feh --bg-fill $(pwd)/${1}|g" /home/eny/.config/bspwm/bspwmrc
		feh --bg-fill "${pwd}/${1}"
		echo -e " $OK ${DCY}Nuevo Fondo de Pantalla${NC} '${CY}$1${NC}'."
	else
		echo -e " $ER ${DCY}No Existe el Archivo${NC} '${DCY}$1${NC}'."
	fi
else
	nDCY="\x1b[0;36m"
	nCY="\x1b[1;36m"
	VER=$(echo $VERSION | sed "s|\.|${nDCY}\.${nCY}|g")
	echo -e " $OK ${CY}$SCRIPT ${DCY}v${CY}$VER${NC}"
	echo
	echo -e " $OK ${GR}Desc${DGR}:${NC} Cambia el fondo de pantalla y agrega persistencia en el archivo '${CY}bspwmrc${NC}'."
	echo
	echo -e " $OK ${GR}Usage${DGR}:${NC}"
	echo -e "	${CY}bgfill${NC} ${DCY}FileName${NC}"
fi

echo
