#!/bin/bash

day=6500
night=1700
hour=$(date +%H)
min=$(date +%M)

if [ ${hour} -ge 0 -a ${hour} -lt 7 ]
then

	temp=${night}

elif [ ${hour} -ge 7 -a ${hour} -lt 17 ]
then

	temp=${day}

elif [ ${hour} -ge 17 ]
then

	calculation="${day} - ((${hour}+${min}/60) - 17) * (${day}-${night}) / 7"
	exact=$(echo "scale=3; ${calculation}" | bc)
	temp="${exact%.*}"

else

	exit 1

fi

echo "Setting redshift temperature: ${temp}"
redshift -v -P -O "${temp}"
