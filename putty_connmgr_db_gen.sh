#!/bin/sh
#This is a script for generating database with hosts (in xml file) to be imported to Putty Connection Manager. It works with PuTTY Connection Manager ver. 0.7.1 BETA (build 136).
# PuTTY Connection Manager is a freeware software authored by Damien Rigoudy

FILE=`less input.txt`
OUTPUT_FILE="putty_db.xml"

HEADER="<?xml version=\"1.0\" encoding=\"utf-16\"?>
<configuration version=\"0.7.1.136\" savepassword=\"True\">
  <root type=\"database\" name=\"TietoHosts\" expanded=\"True\">
      <container type=\"folder\" name=\"TietoTargets\" expanded=\"True\">
"

FOOTER="
</container>
    <container type=\"folder\" name=\"Telnet\" expanded=\"True\" />
	  </root>
	  </configuration> "

BODY=""

for line in $FILE; do
	
 set -- "$line" 
 IFS=";"; declare -a Array=($*)
 host=${Array[0]};
 name=${Array[1]};
 ip=${Array[2]};

echo "name: $name, host: $host, ip:  $ip"; 

BODY_TEMP="<connection type=\"PuTTY\" name=\"$name ($ip, $host)\">
	        <connection_info>
			   <name>$name ($ip, $host)</name>
			       <protocol>SSH</protocol>
				   <host>$ip</host>
				   <port>22</port>
				    <session>Default Settings</session>
				    <commandline />
				   <description />
			</connection_info>
			<login>
				    <login>Nemuadmin</login>
				    <password>nemuuser</password>
				    <prompt />
			</login>
			 <timeout>
				   <connectiontimeout>1000</connectiontimeout>
				   <logintimeout>750</logintimeout>
				   <passwordtimeout>750</passwordtimeout>
				   <commandtimeout>750</commandtimeout>
			 </timeout>
			 <command>
				   <command1>su -</command1>
				   <command2>rastre1</command2>
				   <command3 />
				   <command4 />
				   <command5 />
			  </command>
			  <options>
				   <loginmacro>True</loginmacro>
				   <postcommands>True</postcommands>
				   <endlinechar>10</endlinechar>
			  </options>
	 </connection>
"

echo $BODY_TEMP;
BODY="$BODY
$BODY_TEMP"
done 

echo $HEADER > $OUTPUT_FILE;
echo $BODY >> $OUTPUT_FILE;
echo $FOOTER >> $OUTPUT_FILE;
