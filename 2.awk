#!/usr/bin/env awk -f 

BEGIN {
	FS = " "
	h = 0
	d = 0
}

{
	dir = $1
	if (dir == "forward") 
		h += $2;
	else if (dir == "up")
		d -= $2;
	else if (dir == "down")
		d += $2;	
}

END {
	print h*d
}
