#!/bin/bash

cd /opt/rt-n56u

##SET STORAGE_SIZE
#cp /home/runner/work/auto_build/auto_build/K2P_nano-5.0/kernel-3.4.x-5.0.config trunk/configs/boards/K2P/kernel-3.4.x-5.0.config
sed -i "s/CONFIG_MTD_STORE_PART_SIZ=0x80000/CONFIG_MTD_STORE_PART_SIZ=0x800000/g" trunk/configs/boards/K2P/kernel-3.4.x-5.0.config

##ENABLE HTTPS
sed -i "s/CONFIG_FIRMWARE_INCLUDE_HTTPS=n/CONFIG_FIRMWARE_INCLUDE_HTTPS=y/g" trunk/configs/templates/K2P_nano.config
sed -i "s/CONFIG_FIRMWARE_INCLUDE_OPENSSL_EXE=n/CONFIG_FIRMWARE_INCLUDE_OPENSSL_EXE=y/g" trunk/configs/templates/K2P_nano.config

##ENABLE OPENVPN
sed -i "s/CONFIG_FIRMWARE_INCLUDE_OPENVPN=n/CONFIG_FIRMWARE_INCLUDE_OPENVPN=y/g" trunk/configs/templates/K2P_nano.config

##DISABLE SAMBA SOCAT
#sed -i "s/CONFIG_FIRMWARE_INCLUDE_SMBD36=y/CONFIG_FIRMWARE_INCLUDE_SMBD36=n/g" trunk/configs/templates/K2P_nano.config
#sed -i "s/CONFIG_FIRMWARE_INCLUDE_SOCAT=y/CONFIG_FIRMWARE_INCLUDE_SOCAT=n/g" trunk/configs/templates/K2P_nano.config

##ADD NGINX
cp -r /home/runner/work/auto_build/auto_build/nginx trunk/user/
sed -i "/CONFIG_FIRMWARE_INCLUDE_NGINX/d" trunk/user/Makefile
sed -i '/'CONFIG_FIRMWARE_INCLUDE_xTUN'/a\'"dir_\$(CONFIG_FIRMWARE_INCLUDE_NGINX)                    += nginx" trunk/user/Makefile
echo "CONFIG_FIRMWARE_INCLUDE_NGINX=y" >> trunk/configs/templates/K2P_nano.config

##ADD SMARTDNS
echo "CONFIG_FIRMWARE_INCLUDE_SMARTDNS=y" >> trunk/configs/templates/K2P_nano.config
