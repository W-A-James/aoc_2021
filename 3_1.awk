#!/usr/bin/env awk -f 

BEGIN {
	FS = ""
	gamma = 0
	epsilon = 0
}

function push(arr, b) { arr[length(arr)+1] = b }

{
	# Iterate over bits
	for (i=1;i<=NF;i++) {
		push(arr[i], $i)
	}
}

END {
	for (i=1;i<=NF;i++) {
		
	}

	print gamma*epsilon
}
