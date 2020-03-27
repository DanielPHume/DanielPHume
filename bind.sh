#!/bin/bash

  d=$(date '+%d_%m_%Y_%H_%M')
  f="bind"
  filename=($f$d".txt")
  dir=$(pwd)


  ssh danielh@bind.slough "cat /etc/named/zones/db.slough.imanage.co.uk  > $filename ; exit" ;

  echo "File created on bind server"
  echo $filename


  scp danielh@bind.slough:/home/danielh/$filename $dir
