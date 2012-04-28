#!/usr/bin/env python
f = open('result', 'r')

total = 0
while True:
	line = f.readline()
	if line == '':
		break
	try:
		total += int(line)
		print total
	except ValueError:
		continue
