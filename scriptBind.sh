#!/bin/bash

# Instação do Bind
echo "Instalando o Bind 9"
sudo apt install bind9

# Configuração da zona
echo "Criando zona do dominio"
echo "zone \"teobaldo.net\" {" >> /etc/bind/named.conf.default-zones
echo "   type master;" >> /etc/bind/named.conf.default-zones
echo "   file \"/etc/bind/db.teobaldo.net\";" >> /etc/bind/named.conf.default-zones
echo "};" >> /etc/bind/named.conf.default-zones

# Configuração do dominio
echo "Criando dominio"
echo "\$TTL 86400" >> /etc/bind/db.teobaldo.net
echo "@ IN SOA teobaldo.net. root.teobaldo.net. (" >> /etc/bind/db.teobaldo.net
echo "   1   ;Serial" >> /etc/bind/db.teobaldo.net
echo "   604800   ;Refresh" >> /etc/bind/db.teobaldo.net
echo "   86400   ;Retry" >> /etc/bind/db.teobaldo.net
echo "   2419200   ;Expire" >> /etc/bind/db.teobaldo.net
echo "   86400)   ;Negative Cache TTL" >> /etc/bind/db.teobaldo.net
echo ";" >> /etc/bind/db.teobaldo.net
echo "@    IN   NS   localhost." >> /etc/bind/db.teobaldo.net
echo "www  IN   A    10.7.116.13" >> /etc/bind/db.teobaldo.net
echo "ftp  IN   A    10.7.116.13" >> /etc/bind/db.teobaldo.net
echo "smtp IN   A    10.7.116.13" >> /etc/bind/db.teobaldo.net
echo "pop  IN   A    10.7.116.13" >> /etc/bind/db.teobaldo.net
echo "imap IN   A    10.7.116.13" >> /etc/bind/db.teobaldo.net
echo "mail IN   A    10.7.116.13" >> /etc/bind/db.teobaldo.net
echo "ssh  IN   A    10.7.116.13" >> /etc/bind/db.teobaldo.net

#Configurar arquivo HOSTS
echo "127.0.0.1 localhost" > /etc/hosts
echo "10.7.116.13 usuario-VirtualBox" >> /etc/hosts
echo  " " >> /etc/hosts
echo "# The following lines are desirable for IPv6 capable hosts" >> /etc/hosts
echo "::1     ip6-localhost ip6-loopback" >> /etc/hosts
echo "fe00::0 ip6-localnet" >> /etc/hosts
echo "ff00::0 ip6-mcastprefix" >> /etc/hosts
echo "ff02::1 ip6-allnodes" >> /etc/hosts
echo "ff02::2 ip6-allrouters" >> /etc/hosts

#Configurando DNS local na máquina
echo "nameserver 10.7.116.13" >> /etc/resolvconf/resolv.conf.d/head
echo " " >> /etc/resolvconf/resolv.conf.d/head
sudo service resolvconf restart

#Reiniciar o bind
echo "Restart servidor dns e aplicando configurações..."
/etc/init.d/bind9 restart

#Teste
echo "####### Vamos testa agora!! #######"
echo "Checar arquivo de configurações"
named-checkzone www /etc/bind/db.teobaldo.net
echo "Testa se o servidor foi configurado corretamente!!!"
