#!/bin/bash -x
# This is a script for generating database with hosts (in xml file) to be imported to Putty Connection Manager.
# It was tested on PuTTY Connection Manager ver. 0.7.1 BETA (build 136).
#
# PuTTY Connection Manager is a freeware software authored by Damien Rigoudy

FILE=`less ./input.txt`
OUTPUT_FILE="putty_db.xml"
HEADER=`less ./templates/xml_header.txt`
FOOTER=`less ./templates/xml_footer.txt`
BODY=""

for line in $FILE; do
 data=`echo $line | tr ";" " "`
 dataArray=( $data )

 host=${dataArray[0]};
 name=${dataArray[1]};
 ip=${dataArray[2]};
 
 BODY_FILE='./templates/xml_body.txt'
 BODY_TEMP=`eval "cat <<EOF
 $(<$BODY_FILE)
 EOF
 " 2> /dev/null`

 BODY="$BODY
       $BODY_TEMP"
done 

echo $HEADER > $OUTPUT_FILE;
echo $BODY >> $OUTPUT_FILE;
echo $FOOTER >> $OUTPUT_FILE;
