#!/bin/bash

d=$(date '+%d_%m_%Y_%H_%M')
f="ldapoutput"
filename=($f$d".txt")
dir=$(pwd)


ssh ravnroot@ldap.slough "ldapsearch -x -LLL -b "ou=groups,dc=ravn,dc=co,dc=uk" | grep 'cn:\|memberUid' > $filename;sed -i  's/.*cn:.*/\n&/'  $filename ; exit" ;

echo "File created on ldap server"
echo $filename


scp ravnroot@ldap.slough:/home/ravnroot/$filename $di
