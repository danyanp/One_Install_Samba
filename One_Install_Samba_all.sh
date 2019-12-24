#!/bin/bash
#先安装，避免网络无法下载
if [ `whoami` != "root" ];then
        echo "请切换roo用户，su 密码super0！！！"
        exit
fi
rpm -q samba
rpm -e samba
echo "5秒后开始安装"
sleep 5
yum -y install samba
echo "samba安装成功"

#配置
mkdir /etc/public
chmod 777 /etc/public

wget -O /etc/samba/smb.conf https://www.schoowall.com/smb_mod.conf

#关闭防火墙
#设置ip为同一个网段
service iptables stop
read -p "查看VMnet8，输入ip地址:" address
read -p "请输入配置网卡:" eth
ifconfig ${eth} ${address}
echo "网络配置成功"

#添加用户
read -p "请输入用户名" username
useradd ${username}
smbpasswd -a ${username}
echo "samba添加用户成功"
service smb start
setenforce 0
service smb restart
echo "samba重启成功"
echo "安装完毕，在win7输入\\ $address"

read -p "是否进行创建public共享目录，输入y" address



