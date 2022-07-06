# Nmap functions:

# $1 --> 127.0.0.1
function nmapenum() {sudo nmap -p- --open -sS --min-rate 5000 -vvv -n -Pn $1 -oG allPorts}

# $1 --> 127.0.0.1
function nmapenumt() {sudo nmap -p- --open -sT --min-rate 5000 -vvv -n -Pn $1 -oG allPorts}

# $1 --> 127.0.0.1
function nmapenumu() {sudo nmap -p- --open -sU --min-rate 5000 -vvv -n -Pn $1 -oG allPorts}

# $1 --> 21,22,80...
# $2 --> 127.0.0.1
function nmapscan() {sudo nmap -sCV -p$1 -Pn $2 -oN targeted}

# $1 --> 127.0.0.1
# $2 --> 80,8080...
function nmapwebscan() {
	if [[ -z $2 ]]; then
		nmap --script http-enum -p 80 $1 -oN webScan
	else
		nmap --script http-enum -p $2 $1 -oN webScan
	fi
}

# $1 --> 127.0.0.1
# $2 --> 443,54321...
function nmapsslscan() {
	if [[ -z $2 ]]; then
		nmap --script "vuln and safe" -p 443 $1 -oN sslScan
	else
		nmap --script "vuln and safe" -p $2 $1 -oN sslScan
	fi
}
