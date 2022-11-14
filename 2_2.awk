#!/usr/bin/env awk -f 

BEGIN {
	FS = " "
	h = 0
	d = 0
	aim = 0
}

{
	dir = $1
	x = $2
	if (dir == "forward") {
		h += x
		d += aim*x
	}
	else if (dir == "up") {
		aim -= x
	}
	else if (dir == "down") {
		aim += x
	}
}

END {
	print h*d
}
