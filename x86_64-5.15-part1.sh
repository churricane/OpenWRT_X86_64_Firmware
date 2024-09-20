#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
#check kernel 5.15.150
#git checkout d75705cfc46e90b766869242bf8e748356f8500c

#check kernel 5.15.162
git checkout 8cf859bf012c9619d56cf90e567a381edd1119d8
# Add a feed source
echo 'src-git smpackage https://github.com/kenzok8/small-package' >>feeds.conf.default
#echo 'src-git kenzok8 https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
