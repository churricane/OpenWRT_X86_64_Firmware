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

#cgo enable
sed -i 's/CGO_ENABLED=0/CGO_ENABLED=1/g' feeds/packages/utils/v2dat/Makefile

#remove defaut package
sed -i 's/luci-app-accesscontrol//g' include/target.mk
sed -i 's/luci-app-filetransfer//g' include/target.mk
sed -i 's/luci-app-vlmcsd//g' include/target.mk
sed -i 's/luci-app-wol//g' include/target.mk
sed -i 's/luci-app-ddns//g' include/target.mk
sed -i 's/ddns-scripts_aliyun//g' include/target.mk
sed -i 's/ddns-scripts_dnspod//g' include/target.mk
sed -i 's/luci-app-upnp//g' include/target.mk
sed -i 's/luci-app-vsftpd//g' include/target.mk

#取消Nginx强制转跳https，取消Nginx对登录地址限制
#取消登录IP限制
sed -i "2i sed -i '/restrict_locally/d' /etc/config/nginx" package/lean/default-settings/files/zzz-default-settings
#取消强制转跳https
sed -i "3i sed -i '/302/d' /etc/config/nginx" package/lean/default-settings/files/zzz-default-settings
#设置80端口加载.locations
sed -i "4i uci add_list nginx._redirect2ssl.include='conf.d/*.locations'" package/lean/default-settings/files/zzz-default-settings
#设置Nginx配置生效
sed -i '5i uci commit nginx' package/lean/default-settings/files/zzz-default-settings

#netdata chienese 
rm -rf ./feeds/luci/applications/luci-app-netdata/  
git clone https://github.com/sirpdboy/luci-app-netdata feeds/luci/applications/luci-app-netdata

#update go-lang 1.23
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

#如果Lean的源码出错，lede根目录下，删除多余的
rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd-alt,miniupnpd-iptables,wireless-regdb}
