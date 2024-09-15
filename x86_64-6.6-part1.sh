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
#check kernel 6.6.50
git checkout 530265022e33cd47d21d7ffc31dbd94069fbea4f
# Add a feed source
echo 'src-git smpackage https://github.com/kenzok8/small-package' >>feeds.conf.default
#echo 'src-git kenzok8 https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default

#echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
