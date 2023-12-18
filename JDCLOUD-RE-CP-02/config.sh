#!/bin/bash

cd /opt/rt-n56u

##DELETE BUILD_FIRMWARE_MODIFY CONFIG
sed -i "/sed -i 's\/CONFIG_FIRMWARE_INCLUDE/d" trunk/build_firmware_modify
sed -i "/echo \"CONFIG_FIRMWARE/d" trunk/build_firmware_modify
sed -i "/echo 'CONFIG_FIRMWARE/d" trunk/build_firmware_modify

##COPY CONFIG_FILE
cp /home/runner/work/auto_build/auto_build/JDCLOUD-RE-CP-02/jdcloud-re-cp-02.dts trunk/linux-4.4.x/arch/mips/boot/dts/ralink/

##ENABLE HTTPS
sed -i "s/CONFIG_FIRMWARE_INCLUDE_HTTPS=n/CONFIG_FIRMWARE_INCLUDE_HTTPS=y/g" trunk/configs/templates/JDCLOUD-RE-CP-02.config
sed -i "s/CONFIG_FIRMWARE_INCLUDE_OPENSSL_EXE=n/CONFIG_FIRMWARE_INCLUDE_OPENSSL_EXE=y/g" trunk/configs/templates/JDCLOUD-RE-CP-02.config

##ENABLE OPENVPN
sed -i "s/CONFIG_FIRMWARE_INCLUDE_OPENVPN=n/CONFIG_FIRMWARE_INCLUDE_OPENVPN=y/g" trunk/configs/templates/JDCLOUD-RE-CP-02.config

##DISABLE SAMBA SOCAT
sed -i "s/CONFIG_FIRMWARE_INCLUDE_SMBD36=y/CONFIG_FIRMWARE_INCLUDE_SMBD36=n/g" trunk/configs/templates/JDCLOUD-RE-CP-02.config
sed -i "s/CONFIG_FIRMWARE_INCLUDE_SOCAT=y/CONFIG_FIRMWARE_INCLUDE_SOCAT=n/g" trunk/configs/templates/JDCLOUD-RE-CP-02.config

##ADD NGINX
cp -r /home/runner/work/auto_build/auto_build/nginx trunk/user/
sed -i "/CONFIG_FIRMWARE_INCLUDE_NGINX/d" trunk/user/Makefile
sed -i '/'CONFIG_FIRMWARE_INCLUDE_xTUN'/a\'"dir_\$(CONFIG_FIRMWARE_INCLUDE_NGINX)                    += nginx" trunk/user/Makefile
echo "CONFIG_FIRMWARE_INCLUDE_NGINX=y" >> trunk/configs/templates/JDCLOUD-RE-CP-02.config

##ADD SMARTDNS
echo "CONFIG_FIRMWARE_INCLUDE_SMARTDNS=y" >> trunk/configs/templates/JDCLOUD-RE-CP-02.config

##ADD SQM-QOS
echo "CONFIG_FIRMWARE_INCLUDE_SQM=y" >> trunk/configs/templates/JDCLOUD-RE-CP-02.config

##DISABLE DELETING THE ASP FOR VPN
sed -i "/vpn/d" trunk/user/www/Makefile

##UPDATE SMARTDNS TO RELEASE43
cp /home/runner/work/auto_build/auto_build/smartdns-Release43.tar.gz trunk/user/smartdns/
sed -i "s/smartdns-ba282c8/smartdns-Release43/g" trunk/user/smartdns/Makefile
