#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# Modify default theme
sed -i 's/luci-theme-bootstrap/luci-theme-argone/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

#ssh bash
sed -i 's/\/bin\/ash/\/bin\/bash/' package/base-files/files/etc/passwd

#empty password
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

#kernel 5.15
sed -i 's/KERNEL_PATCHVER:=6.1/KERNEL_PATCHVER:=5.15/g' target/linux/x86/Makefile

#cgo enable
sed -i 's/CGO_ENABLED=0/CGO_ENABLED=1/g' feeds/packages/utils/v2dat/Makefile

#remove defaut package
sed -i 's/luci-app-accesscontrol//g' include/target.mk
sed -i 's/luci-app-filetransfer//g' include/target.mk
sed -i 's/luci-app-vlmcsd//g' include/target.mk
sed -i 's/luci-app-wol//g' include/target.mk

#netdata chienese 
rm -rf ./feeds/luci/applications/luci-app-netdata/  
git clone https://github.com/sirpdboy/luci-app-netdata feeds/luci/applications/luci-app-netdata

#update go-lang 1.22
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang

