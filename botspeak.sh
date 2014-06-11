#!/bin/bash
#Script for getting the bash bot to say things into IRC. Extremely simple but it can be useful.
output=".bot.cfg"
go=1
while [ "$go" = 1 ]; do
 echo "Hmm, what am I going to say..."
 read speak
 echo "$speak" >> $output
done
