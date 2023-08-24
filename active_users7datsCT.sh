#!/bin/bash

# Mail to tkeer@qti.qualcomm.com 
# Install 5.2 UDR decoder on RULS component from  /qln/release/tools/UDRDecoder/5.2.0.01/x86_64
# Save the script in /usr/local/qualcomm/tools/udr_decoder/bin/ location on the RULS component
# Check/Update the active UDR directory PATH below
# give executable permission to script #chmod 777 active_users7daysCT.sh
# run the script #./active_users7daysCT.sh 


#This is the active UDR directory path...
cd /local/mnt/workspace/QCOMQCHAT/RULSUDR/

#OUTPUT="$(find . -type f -mtime -7 -print)" .....files generated in last '7'-(edit this to get output for different No. of) days
OUTPUT="$(find /local/mnt/workspace/QCOMQCHAT/RULSUDR/ -type f -mtime -7 -print)"
#echo "${OUTPUT}"

cp -ar ${OUTPUT} /usr/local/qualcomm/tools/udr_decoder/bin/


sleep 1;

echo -e "Running the UDR decoder on catch....!!!\n"

cd /usr/local/qualcomm/tools/udr_decoder/bin/

#what are my files... 
UDRFILES="$(find   *.UDR -print)"


echo -e "${UDRFILES}" > list.txt
sleep 1;


while read line; do
    echo $line

./UDRDecoder -i $line -o  $line.txt -NT
done < list.txt

sleep 2;

#output
echo -e  "\n\n"
echo -e "++++++++++++active users and groups for last 7 days are++++\n"

cat *.txt | grep -i @ | awk '!a[$0]++'

echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"

sleep 2;

#clean-up
rm -rf *.UDR UDR.* *.txt *.XML XML.*
#end of script

