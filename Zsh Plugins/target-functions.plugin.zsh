# IP Validation (port is optional)
function isValidIP(){
        ip='^((2([0-4][0-9]|5[0-5])?|[0-1]?[0-9]{1,2})?\.){3}'
        ip+='((2([0-4][0-9]|5[0-5])?|[0-1]?[0-9]{1,2})?)'
        limit='6([0-4][0-9]{3}|5([0-4][0-9]{2}|5([0-2][0-9]|3[0-5])))'
        port='(:(([0-9]{1,4})|([0-5]?[0-9]{1,4})|('$limit')))?$'
        [[ $1 =~ $ip$port ]] && return 1 || return 0
}

# set Target:
function setTarget(){
        ip_address=$1
        machine_name=$2
        echo "$ip_address $machine_name" > ~/.target
}

# get Target:
function getTarget(){
        # Copy: echo -n 'xD' | xclip -selection clipboard
        # Paste: xclip -selection clipboard -o
        temp1=$(cat ~/.target | awk '{print $1}')
        temp2=$(cat ~/.target | awk '{print $2}')
        ip_address=""
        machine_name=""
        IP=false
        NAME=false
        SILENT=false
        HELP=false
        LAST=""
        SHIFTED=()
        # Extraccion de Parametros ---------------------------------------------
        while [[ $# -gt 0 ]]; do
            case $1 in
                -i|-ip|--ip|ip) IP=true; LAST="IP"; shift;;
                -n|-name|--name|name|-m|-machine|--machine|machine) NAME=true; LAST="NAME"; shift;;
                -s|-silent|--silent|silent) SILENT=true; shift;;
                -is|-si|-ips|-sip) IP=true; SILENT=true; LAST="IP"; shift;;
                -ns|-sn|-ms|-sm) NAME=true; SILENT=true; LAST="NAME"; shift;;
                -in|-im|-ipn|-ipm) IP=true; NAME=true; LAST="NAME"; shift;;
                -ni|-mi|-nip|-mip) IP=true; NAME=true; LAST="IP"; shift;;
                -sin|-sim|-sipn|-sipm) IP=true; NAME=true; SILENT=true; LAST="NAME"; shift;;
                -sni|-smi|-snip|-smip) IP=true; NAME=true; SILENT=true; LAST="IP"; shift;;
                -isn|-ism|-ipsn|-ipsm) IP=true; NAME=true; SILENT=true; LAST="NAME"; shift;;
                -nsi|-msi|-nsip|-msip) IP=true; NAME=true; SILENT=true; LAST="IP"; shift;;
                -ins|-ims|-ipns|-ipms) IP=true; NAME=true; SILENT=true; LAST="NAME"; shift;;
                -nis|-mis|-nips|-mips) IP=true; NAME=true; SILENT=true; LAST="IP"; shift;;
                -h|-help|--help|help) HELP=true; shift;;
                *) SHIFTED+=("$1"); shift;;
            esac
        done
        # Validación de IP -----------------------------------------------------
        isValidIP $temp1
        isvalid=$?
        if [[ $isvalid -eq 1 ]]; then
                ip_address=$temp1
                if [[ -n $temp2 ]]; then
                        machine_name=$temp2
                fi
        else
                machine_name=$temp1
        fi
        isValidIP $temp2
        isvalid=$?
        if [[ $isvalid -eq 1 ]]; then
                ip_address=$temp2
        fi
        # ----------------------------------------------------------------------
        if [[ $HELP == true ]]; then
                echo "Usage: gettarget [-h] | [-ip -name -silent | -ins]"
                echo "    -i, ip       Copia la IP del 'target' en el Clipboard (Ver: settarget)"
                echo "    -n, name     Copia el nombre del 'target' en el Clipboard (Ver: settarget)"
                echo "    -s, silent   Muestra la IP/Nombre del 'Target'. Ejemplo: echo 'Target IP:' \$(gettarget -s)"
                echo "    -h, help     Muestra esta ayuda."
                echo .
                echo "Ejemplos:"
                echo "    gettarget                 # Copied To Clipboard: 127.0.0.1"
                echo "    gettarget name            # Copied To Clipboard: localhost"
                echo "    gettarget -s              # 127.0.0.1"
                echo "    gettarget -sn             # localhost"
                echo "    gettarget ip name silent  # 127.0.0.1 localhost"
                echo "    gettarget name ip -s      # localhost 127.0.0.1"
                echo "    gettarget -i -n           # Copied To Clipboard: 127.0.0.1 localhost"
                echo "    gettarget -ni             # Copied To Clipboard: localhost 127.0.0.1"
        elif [[ -n $SHIFTED ]]; then
                echo "Error: $SHIFTED"
        elif [[ $SILENT == true ]]; then
                if [[ -n $ip_address && -n $machine_name && $IP == true && $NAME == true ]]; then
                        if [[ $LAST == "NAME" ]]; then
                                echo "$ip_address $machine_name"
                        elif [[ $LAST == "IP" ]]; then
                                echo "$machine_name $ip_address"
                        fi
                elif [[ -n $ip_address && $NAME == false ]] || [[ -n $ip_address && $IP == true ]]; then
                        echo "$ip_address"
                elif [[ -n $machine_name && $IP == false ]] || [[ -n $machine_name && $NAME == true ]]; then
                        echo "$machine_name"
                fi
        else
                if [[ -n $ip_address && -n $machine_name && $IP == true && $NAME == true ]]; then
                        if [[ $LAST == "NAME" ]]; then
                                echo -n "$ip_address $machine_name" | xclip -sel clip
                                echo "Copied To Clipboard: $ip_address $machine_name"
                        elif [[ $LAST == "IP" ]]; then
                                echo -n "$machine_name $ip_address" | xclip -sel clip
                                echo "Copied To Clipboard: $machine_name $ip_address"
                        fi
                elif [[ -n $ip_address && $NAME == false ]] || [[ -n $ip_address && $IP == true ]]; then
                        echo -n "$ip_address" | xclip -sel clip
                        echo "Copied To Clipboard: $ip_address"
                elif [[ -n $machine_name && $IP == false ]] || [[ -n $machine_name && $NAME == true ]]; then
                        echo -n "$machine_name" | xclip -sel clip
                        echo "Copied To Clipboard: $machine_name"
                else
                        echo "No Target"
                fi
        fi
}

alias settarget='setTarget'
alias gettarget='getTarget'
alias isvalidip='isValidIP'
