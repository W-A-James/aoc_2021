#!/usr/bin/awk -f

BEGIN {
	FS = ""
  
}

{
	# Iterate over bits
	for (i=1;i<=NF;i++) {
    arr[i,NR] = $i
	}
}

END {
	gamma = 0
	epsilon = 0
  mask = 0

	for (i=1;i<=NF;i++) {
    # Iterates over each bit
    sum = 0
    # Counts up 1s
    for (ii=1;ii<=NR;ii++) {
      sum = sum + arr[i,ii]
    }

    if (sum >= NR/2) {
      gamma = or(gamma, lshift(1, NF-i))
    } else {
      epsilon = or(epsilon, lshift(1, NF-i))
    }
	}

	print gamma
  print epsilon
  print gamma*epsilon
}
