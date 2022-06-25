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
        echo "$ip_address $machine_name" > ~/target.tmp
}

# get Target:
function getTarget(){
        # Copy: echo -n 'xD' | xclip -selection clipboard
        # Paste: xclip -selection clipboard -o
        temp1=$(cat ~/target.tmp | awk '{print $1}')
        temp2=$(cat ~/target.tmp | awk '{print $2}')
        ip_address=""
        machine_name=""
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
        if [[ -n $1 ]]; then
                if [[ $1 == "-ip" || $1 == "--ip" || $1 == "-i" ]]; then
                        if [[ -n $ip_address ]]; then
                                echo -n "$ip_address" | xclip -sel clip
                                echo "Copied To Clipboard: $ip_address"
                        else
                                echo "No Target IP"
                        fi
                elif [[ $1 == "-name" || $1 == "--name" || $1 == "-n" ]]; then
                        if [[ -n $machine_name ]]; then
                                echo -n "$machine_name" | xclip -sel clip
                                echo "Copied To Clipboard: $machine_name"
                        else
                                echo "No Target Name"
                        fi
                else
                        echo "Error: $1"
                fi
        else
                if [[ $ip_address ]]; then
                        echo -n "$ip_address" | xclip -sel clip
                        echo "Copied To Clipboard: $ip_address"
                elif [[ $machine_name ]]; then
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
