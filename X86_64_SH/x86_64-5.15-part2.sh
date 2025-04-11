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
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

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
#sed -i 's/CGO_ENABLED=0/CGO_ENABLED=1/g' feeds/packages/utils/v2dat/Makefile

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
#rm -rf ./feeds/luci/applications/luci-app-netdata/  
#git clone https://github.com/sirpdboy/luci-app-netdata feeds/luci/applications/luci-app-netdata

#update go-lang 1.23
#rm -rf feeds/packages/lang/golang
#git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

#如果Lean的源码出错，lede根目录下，删除多余的
rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd-alt,miniupnpd-iptables,wireless-regdb}

#kernel_5.15添加核显驱动
cat >> ./target/linux/x86/config-5.15 << EOF
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_ACPI_VIDEO=y
CONFIG_ARCH_CONFIGURES_CPU_MITIGATIONS=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_CPU_MITIGATIONS=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DRM=y
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_I915=y
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
# CONFIG_DRM_I915_SELFTEST is not set
CONFIG_DRM_I915_STOP_TIMEOUT=100
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
CONFIG_DRM_I915_TIMESLICE_DURATION=1
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_WERROR is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_PANEL=y
CONFIG_DRM_PANEL_BRIDGE=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_TTM=y
CONFIG_FB_CMDLINE=y
CONFIG_FRAME_WARN=1024
CONFIG_FUNCTION_ALIGNMENT=4
CONFIG_FUNCTION_ALIGNMENT_4B=y
# CONFIG_GDS_FORCE_MITIGATION is not set
CONFIG_HDMI=y
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_INTEL_GTT=y
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_INTERVAL_TREE=y
CONFIG_KCMP=y
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_MITIGATION_RFDS=y
CONFIG_MITIGATION_SPECTRE_BHI=y
CONFIG_MMU_NOTIFIER=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_PPS=y
CONFIG_RELAY=y
CONFIG_RTC_I2C_AND_SPI=y
# CONFIG_RTS5139 is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
CONFIG_SYNC_FILE=y
CONFIG_VMAP_PFN=y
CONFIG_ZLIB_DEFLATE=y
EOF
