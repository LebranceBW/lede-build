#!/usr/bin/env bash

# modify login IP
#sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# modify host name
#sed -i 's/OpenWrt/Xiaomi-Router/g' package/base-files/files/bin/config_generate
#sed -i 's/OpenWrt/Phicomm-Router/g' package/base-files/files/bin/config_generate

# modify device name show
#sed -i 's/Xiaomi Mi Router 4A Gigabit Edition/Xiaomi 4A Gigabit/g' target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-gigabit.dts
#sed -i 's/Xiaomi Mi Router 3G v2/Xiaomi 3G v2/g' target/linux/ramips/dts/mt7621_xiaomi_mi-router-3g-v2.dts
#sed -i 's/Xiaomi Redmi Router AC2100/Redmi AC2100/g' target/linux/ramips/dts/mt7621_xiaomi_redmi-router-ac2100.dts
#sed -i 's/Xiaomi Mi Router AC2100/Xiaomi AC2100/g' target/linux/ramips/dts/mt7621_xiaomi_mi-router-ac2100.dts
#sed -i 's/Xiaomi Mi Router CR660x/Xiaomi CR660x/g' target/linux/ramips/dts/mt7621_xiaomi_mi-router-cr6606.dts

# copy smartdns configuration
#sed -i 's#$(PKG_BUILD_DIR)/package/openwrt/address.conf#$(CURDIR)/files/address.conf#g' feeds/packages/net/smartdns/Makefile
#sed -i 's#$(PKG_BUILD_DIR)/package/openwrt/files/etc/config/smartdns#$(CURDIR)/files/smartdns#g' feeds/packages/net/smartdns/Makefile
#cp -r $(dirname $0)/../extra-files/smartdns/files feeds/packages/net/smartdns/

# copy uci-defaults script(s)
mkdir -p files/etc/uci-defaults
cp $(dirname $0)/uci-scripts/* files/etc/uci-defaults/

# switch ramips kernel to 5.10
sed -i '/KERNEL_PATCHVER/cKERNEL_PATCHVER:=5.10' target/linux/ramips/Makefile

# switch ramips kernel to 5.15
#sed -i '/KERNEL_PATCHVER/cKERNEL_PATCHVER:=5.15' target/linux/ramips/Makefile

# copy kernel 5.10 version CPU overclocking patch
#cp $(dirname $0)/../extra-files/322-mt7621-fix-cpu-clk-add-clkdev.patch target/linux/ramips/patches-5.10/

# set up WiFi
#sed -i 's/OpenWrt/coolxiaomi/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i 's/wireless.default_radio${devidx}.encryption=none/wireless.default_radio${devidx}.encryption=psk-mixed/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i '/encryption/a\set wireless.default_radio${devidx}.key=coolxiaomi' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i '/encryption/a\set wireless.default_radio${devidx}.key=coolphicomm' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# modify login password to coolxiaomi
#sed -i '/root/croot:$1$CBd7u73H$LvSDVXLBrzpk4JfuuN.Lv1:18676:0:99999:7:::' package/base-files/files/etc/shadow

# replace geodata source
. $(dirname $0)/../extra-files/update-geodata.sh
# 修改openwrt登陆地址,把下面的192.168.5.1修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把Xiaomi-R4A修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='Xiaomi4A_Router'' package/lean/default-settings/files/zzz-default-settings

# 版本号里显示一个自己的名字（ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i "s/OpenWrt /LebranceBW build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argone/g' feeds/luci/collections/luci/Makefile
