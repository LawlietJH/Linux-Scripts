# Nmap functions:

# $1 --> 127.0.0.1
function nmapenum() {sudo nmap -p- --open -sS --min-rate 5000 -vvv -n -Pn $1 -oG allPorts}

# $1 --> 127.0.0.1
function nmapenumt() {sudo nmap -p- --open -sT --min-rate 5000 -vvv -n -Pn $1 -oG allPorts}

# $1 --> 21,22,80
# $2 --> 127.0.0.1
function nmapscan() {sudo nmap -sCV -p$1 -Pn $2 -oN targeted}

# $1 --> 127.0.0.1
function nmapwebscan() {nmap --script http-enum -p 80,$2 $1 -oN webScan}

# $1 --> 127.0.0.1
function nmapsslscan() {nmap --script "vuln and safe" -p 443,$2 $1 -oN sslScan}
