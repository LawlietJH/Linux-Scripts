# Get Public IP:
function getPublicIP(){
        # nslookup myip.opendns.com resolver1.opendns.com | awk '{print $2}' | sed '/^$/d' | tail -n 1
        # host myip.opendns.com resolver1.opendns.com | tail -n 1 | awk '{print $NF}'
        ## awk {NF-=1; print $NF} # Este ejemplo mostraría el penultimo elemento
        IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
        echo -n "$IP" | xclip -sel clip
        if [[ $1 != '-s' ]]; then echo "Copied to Clipboard: $IP"; fi
}

# Get Local IP:
function getLocalIP(){
        IP_name='enp0s3'
        if [[ -n $1 && $1 != '-s' ]]; then IP_name=$1; elif [[ -n $2 ]]; then IP_name=$2; fi
        IP=$(ifconfig -a $IP_name | grep 'inet ' | awk '{print $2}')
        echo -n "$IP" | xclip -sel clip
        if [[ $1 != '-s' && $2 != '-s' ]]; then echo "Copied to Clipboard '$IP_name': $IP"; fi
}

alias getpublicip='getPublicIP'
alias getlocalip='getLocalIP'
alias gettun0='getLocalip tun0'
