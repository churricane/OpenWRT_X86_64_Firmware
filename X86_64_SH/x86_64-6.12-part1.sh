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
#check kernel 6.6.90
#git checkout b3f63c7948b4b59df5f837b9e3bc343c22f74798
#check kernel 6.6.91
#git checkout 6620a5e83caca39793b72e9a531a0d73e9ee3b67
#check kernel 6.6.92
#git checkout 6a5bb9d211ec45718d4956dd3deb976aa07e79fe
git checkout tags/v24.10.1
# Add a feed source
echo 'src-git smpackage https://github.com/kenzok8/small-package' >>feeds.conf.default
#echo 'src-git kenzok8 https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default

#echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
