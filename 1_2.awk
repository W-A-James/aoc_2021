#!/usr/bin/env awk -f

BEGIN {
	idx = 0
}

{
	vals[idx] = $0
	idx++
}

END {
	len = idx
	count = 0
	current_sum = 9999999

	for (idx = 0; idx < len-2; idx++) {
		new_sum = vals[idx] + vals[idx+1] + vals[idx+2]
		if (new_sum > current_sum)
			count++	
		current_sum = new_sum
	}
	print count
}
