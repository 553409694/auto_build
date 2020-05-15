#!/bin/bash

cd /opt/rt-n56u
cp /home/runner/work/auto_build/auto_build/K2P_nano-5.0/kernel-3.4.x-5.0.config trunk/configs/boards/K2P/kernel-3.4.x-5.0.config
sed -i "s/CONFIG_FIRMWARE_INCLUDE_HTTPS=n/CONFIG_FIRMWARE_INCLUDE_HTTPS=y/g" trunk/configs/templates/K2P_nano-5.0.config
sed -i "s/CONFIG_FIRMWARE_INCLUDE_OPENSSL_EXE=n/CONFIG_FIRMWARE_INCLUDE_OPENSSL_EXE=y/g" trunk/configs/templates/K2P_nano-5.0.config
sed -i "s/CONFIG_FIRMWARE_INCLUDE_OPENVPN=n/CONFIG_FIRMWARE_INCLUDE_OPENVPN=y/g" trunk/configs/templates/K2P_nano-5.0.config
