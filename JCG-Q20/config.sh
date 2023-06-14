#!/bin/bash

cd /opt/rt-n56u

##DELETE BUILD_FIRMWARE_MODIFY CONFIG
sed -i "/sed -i 's\/CONFIG_FIRMWARE_INCLUDE/d" trunk/build_firmware_modify
sed -i "/echo \"CONFIG_FIRMWARE/d" trunk/build_firmware_modify
sed -i "/echo 'CONFIG_FIRMWARE/d" trunk/build_firmware_modify

##COPY CONFIG_FILE
cp /home/runner/work/auto_build/auto_build/JCG-Q20/jcg-q20.dts trunk/linux-4.4.x/arch/mips/boot/dts/ralink/
cp /home/runner/work/auto_build/auto_build/JCG-Q20/JCG-Q20.config trunk/configs/templates/

##ENABLE HTTPS
sed -i "s/CONFIG_FIRMWARE_INCLUDE_HTTPS=n/CONFIG_FIRMWARE_INCLUDE_HTTPS=y/g" trunk/configs/templates/JCG-Q20.config
sed -i "s/CONFIG_FIRMWARE_INCLUDE_OPENSSL_EXE=n/CONFIG_FIRMWARE_INCLUDE_OPENSSL_EXE=y/g" trunk/configs/templates/JCG-Q20.config

##ENABLE OPENVPN
sed -i "s/CONFIG_FIRMWARE_INCLUDE_OPENVPN=n/CONFIG_FIRMWARE_INCLUDE_OPENVPN=y/g" trunk/configs/templates/JCG-Q20.config

##DISABLE SAMBA SOCAT
sed -i "s/CONFIG_FIRMWARE_INCLUDE_SMBD36=y/CONFIG_FIRMWARE_INCLUDE_SMBD36=n/g" trunk/configs/templates/JCG-Q20.config
sed -i "s/CONFIG_FIRMWARE_INCLUDE_SOCAT=y/CONFIG_FIRMWARE_INCLUDE_SOCAT=n/g" trunk/configs/templates/JCG-Q20.config

##ADD NGINX
cp -r /home/runner/work/auto_build/auto_build/nginx trunk/user/
sed -i "/CONFIG_FIRMWARE_INCLUDE_NGINX/d" trunk/user/Makefile
sed -i '/'CONFIG_FIRMWARE_INCLUDE_xTUN'/a\'"dir_\$(CONFIG_FIRMWARE_INCLUDE_NGINX)                    += nginx" trunk/user/Makefile
echo "CONFIG_FIRMWARE_INCLUDE_NGINX=y" >> trunk/configs/templates/JCG-Q20.config

##ADD SMARTDNS
#echo "CONFIG_FIRMWARE_INCLUDE_SMARTDNS=y" >> trunk/configs/templates/JCG-Q20.config
