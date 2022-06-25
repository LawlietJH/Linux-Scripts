# mkt: Creación de carpetas para hacer CTFs:
function mkt(){
	DIR=""
	CHALLENGE=false
	SHIFTED=()
	# Extraccion de Parametros
	while [[ $# -gt 0 ]]; do
		case $1 in
			-c|--challenge) CHALLENGE=true; shift;;
			*) SHIFTED+=("$1"); shift;;
		esac
	done
	DIR=${SHIFTED[1]}
	if [[ -n $DIR ]]; then
		if [[ ! -d $DIR ]]; then
			mkdir $DIR
			cd $DIR
			if [[ $CHALLENGE == true ]]; then
				echo '# Challenge: '$DIR > data.txt
				echo '# Challenge: '$DIR > flag.txt
				echo 'Flag: ' >> flag.txt
			else
				mkdir {content,exploits,nmap}
				cd content
				echo '# Machine: '$DIR > data.txt
				echo '# Machine: '$DIR > flags.txt
				echo 'User Flag: ' >> flags.txt
				echo 'Root Flag: ' >> flags.txt
			fi
		else
			echo 'Ya existe el directorio: '$DIR
		fi
	else
		echo 'Se requiere el nombre de un Directorio...'
	fi
}

# Extract nmap information:
function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	if [[ $2 == '-s' ]]; then
		echo $ports
	else
		echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
		echo -e "\t[*] IP Address: $ip_address" >> extractPorts.tmp
		echo -e "\t[*] Open ports: $ports\n" >> extractPorts.tmp
		echo $ports | tr -d '\n' | xclip -sel clip
		echo -e "[*] Ports copied to clipboard\n" >> extractPorts.tmp
		bat extractPorts.tmp -l java
		rm extractPorts.tmp
	fi
}

alias extractports='extractPorts'
