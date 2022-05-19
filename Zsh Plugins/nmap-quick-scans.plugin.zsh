# Nmap functions:

# $1 --> 127.0.0.1
function nmapenum() {sudo nmap -p- --open -sS --min-rate 5000 -vvv -n -Pn $1 -oG allPorts}

# $1 --> 21,22,80
# $2 --> 127.0.0.1
function nmapscan() {sudo nmap -sCV -p$1 $2 -oN targeted}
