#! /bin/bash
# Funciones para añadir al archivo ~/.zshrc
# Requiere: mkdir ~/target.tmp

# settarget
function settarget(){
        ip_address=$1
        machine_name=$2
        echo "$ip_address $machine_name" > ~/target.tmp
}

# gettarget
function gettarget(){
        # Copy: echo -n 'xD' | xclip -selection clipboard
        # Paste: xclip -selection clipboard -o
        temp1=$(cat ~/target.tmp | awk '{print $1}')
        temp2=$(cat ~/target.tmp | awk '{print $2}')
        ip_address=""
        machine_name=""
        if [[ $temp1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
                ip_address=$temp1
                if [[ -n $temp2 ]]; then
                        machine_name=$temp2
                fi
        else
                machine_name=$temp1
        fi
        if [[ $temp2 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
                ip_address=$temp2
        fi
        if [[ -n $1 ]]; then
                if [[ $1 == "-ip" || $1 == "--ip" || $1 == "-i" ]]; then
                        if [[ -n $ip_address ]]; then
                                echo -n "$ip_address" | xclip -selection clipboard
                                echo "Copied To Clipboard: $ip_address"
                        else
                                echo "No Target IP"
                        fi
                elif [[ $1 == "-name" || $1 == "--name" || $1 == "-n" ]]; then
                        if [[ -n $machine_name ]]; then
                                echo -n "$machine_name"  | xclip -selection clipboard
                                echo "Copied To Clipboard: $machine_name"
                        else
                                echo "No Target Name"
                        fi
                else
                        echo "Error: $1"
                fi
        else
                if [[ $ip_address ]]; then
                        echo -n "$ip_address" | xclip -selection clipboard
                        echo "Copied To Clipboard: $ip_address"
                elif [[ $machine_name ]]; then
                        echo -n "$machine_name" | xclip -selection clipboard
                        echo "Copied To Clipboard: $machine_name"
                else
                        echo "No Target"
                fi
        fi
}
