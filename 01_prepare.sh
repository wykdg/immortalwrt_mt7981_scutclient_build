
./scripts/feeds update -a

# 单独拉取mosdns的库
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 20.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

#单独拉取scutclient
rm -rf feeds/luci/applications/luci-app-scutclient/
git clone https://github.com/wykdg/luci-app-scutclient.git feeds/luci/applications/luci-app-scutclient 



./scripts/feeds install -a


#在启动项加入联通加速
sed -i '3i #如果使用联通加速，删除前面的#，并填充后面的值\n#sleep 10 && /usr/share/scut_unicom/add_route.sh server_ip username password' package/base-files/files/etc/rc.local 
#将ttyd改成默认root登录
sed -i "s/option command '\/bin\/login'/option command '\/bin\/login -f root'/" feeds/packages/utils/ttyd/files/ttyd.config 


sed  -i "s/exit 0/[ ! -f '\/usr\/sbin\/trojan' ] \&\& [ -f '\/usr\/bin\/trojan-go' ] \&\& ln -sf \/usr\/bin\/trojan-go \/usr\/bin\/trojan\nexit 0/" package/emortal/default-settings/files/99-default-settings                

