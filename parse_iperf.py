#!/usr/bin/python

import sys

def get_content(filename):
	fp = open(filename)
	content = fp.read()
	fp.close()
	return content

def parse_iperf(content):
	lines = content.split("\n")
	print lines
	for	line in lines:
		if line.find("sec") >= 0:
			print line
			words = line.split(" ")
			print words
			i = 0
			for word in words:
				if word.find("Mbits") >= 0:
					print words[i-1]
				i += 1
					

if __name__=="__main__":
	argvs = sys.argv
	if len(argvs) != 2:
		sys.exit()
	fname = argvs[1]
	content = get_content(fname)
	print "Get all contents in a file"
	print content
	print
	print
	print "Lets parse content"
	parse_iperf(content)
