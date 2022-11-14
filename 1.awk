#!/usr/bin/env awk -f

BEGIN {
	count=0
	current=99999
}

{
	if ($0 > current)
		count=count+1
	current = $0
}

END {
	print count 
}
