 #!/bin/bash

 echo -e "\n Initial setup script\n"

 read -p "Hostname: " HOSTNAME
 read -p "IP Address: " IP

 echo $HOSTNAME > /etc/hostname
 sed -i "s/127.0.0.1.*/127.0.0.1\t$HOSTNAME/g" /etc/hosts
 sed -i "s/10.103.*/$IP\t$HOSTNAME.ch3.imanage.work\t$HOSTNAME/g" /etc/hosts
 sed -i "s/address.*/address $IP/g" /etc/network/interfaces
 sed -i "s/netmask.*/netmask 255.255.128.0/g" /etc/network/interfaces
 sed -i "s/gateway.*/gateway 10.103.128.2/g" /etc/network/interfaces

 service networking restart
 echo -e "Network updated successfully"

 export http_proxy="http://10.103.0.63:3128"
 export https_proxy="http://10.103.0.63:3128"

 echo 'Acquire::http::Proxy "http://10.103.0.63:3128";' > /etc/apt/apt.conf
 echo 'Acquire::https::Proxy "https://10.103.0.63:3128";' >> /etc/apt/apt.conf
 apt-get update
 echo -e "Apt updated successfully"

 apt-get install ntp -y
 sed -i "s/pool 0.*/server 10.103.128.2/g" /etc/ntp.conf
 sed -i "19d" /etc/ntp.conf
 sed -i "20d" /etc/ntp.conf
 sed -i "21d" /etc/ntp.conf
 echo -e "Ntp updated successfully"

 apt-get install salt-minion -y
 echo $HOSTNAME > /etc/salt/minion_id
 sed -i "s/#master: salt.*/master: salt/g" /etc/salt/minion
 echo "master: salt" >> /etc/salt/minion
 echo -e "Salt Minion updated successfully"

 reboot now
 echo -e "Configuration Updated. Rebooting Now.\n"
 exit 0
