#! /usr/bin/python3
#
# By: LawlietJH - Ubz2 v1.0
#
# Desc: Compresión de archivos con el algoritmo 'bz2'.
#
# Usage:
#	ubz2 -c FileName		# Compresión
#	ubz2 -d FileName.ubz2		# Descompresión

import bz2
import sys
import os

SCRIPT = 'ubz2'
VERSION = '1.0'

arg_c = '-c' in sys.argv
arg_d = '-d' in sys.argv
arg_h = '-h' in sys.argv
arg_v = '-v' in sys.argv
if arg_c: sys.argv.remove('-c')
if arg_d: sys.argv.remove('-d')
if arg_h: sys.argv.remove('-h')
if arg_v: sys.argv.remove('-v')

print()

if len(sys.argv) == 2:
	file_name = sys.argv[1]
	if os.path.isfile(file_name):
		if arg_c and not arg_d:
			with open(file_name, 'rb') as f:
				orig_data = f.read()
				len_orig_d = len(orig_data)
				compressed = bz2.compress(orig_data)
				print(f' [+] Total:      {len_orig_d} bytes')
				len_c = len(compressed)
				print(f' [+] Resultado:  {len_c} bytes')
			with open(file_name+'.ubz2', 'wb') as f:
				f.write(compressed)
			compressed_pct = 100-round(len_c/len_orig_d, 3)*100
			print(f' [+] Compresión: {compressed_pct}%')
		elif arg_d and not arg_c:
			out_fn = file_name
			if file_name.endswith('.ubz2'):
				out_fn = file_name[:-5]
			with open(file_name, 'rb') as f:
				compressed_data = f.read()
				decompressed = bz2.decompress(compressed_data)
				len_d = len(decompressed)
				print(f' [+] Extraídos: {len_d} bytes')
			with open('_'+out_fn, 'wb') as f:
				f.write(decompressed)
		else:
			print(' [+] Usage:\n')
			print('\t ubz2 -c FileName')
			print('\t ubz2 -d FileName.ubz2')
	else:
		print(' [!] El Archivo No Existe')
elif arg_v:
	print(f' [+] {SCRIPT} v{VERSION}')
else:
	print(' [+] Usage:\n')
	print('\t ubz2 -c FileName')
	print('\t ubz2 -d FileName.ubz2')

print()
