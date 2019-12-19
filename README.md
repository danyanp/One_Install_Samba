# One_install_Samba
## 记一次 Linux 安装samba软件
> ## 实现Centos6.7一键安装samba，并实现相关功能，以下为相关操作
- ## 1、安装samba软件：yum install samba;
- ## 2、查询是否安装samba：rpm -q samba
- ## 3、关闭windows防火墙，Linux防火墙
- ## 4、设置Linux网络IP地址与windows中VMnet8的IP地址在同一网段
   - ### windows中查看IP地址的配置命令：ipconfig
   - ### Linux 中查看IP地址的配置命令：ifconfig
   - ### ifconfig 设置IP地址的格式：ifconfig 网卡名称 IP地址
- ## 5、添加Linux用户
   - ### 添加samba用户（samba用户首先应该是Linux用户）
   - ### smbpasswd -a Linux用户名
- ## 6、启动samba服务：service smb start 
   - ### service smb restart(改变了samba相关设置)
- ## 7、登录：windows中输入LinuxIP地址登录，登录时输入samba用户名和密码
   - ### \\Linux IP地址
- ## 8、阅读并修改 /etc/samba/smb.conf文档实现7、8功能
---
# 配置说明
 ![配置说明](https://github.com/danyanp/One_Install_Samba/blob/master/Samba_Explain.png?raw=true)
---
# 一键安装的使用及原理
## 1. [开源地址](https://github.com/danyanp/One_Install_Samba)
## 2. 使用
   - ### 在命令提示框中，以root用户运行One_Install_Samba.sh文件
   ```
   ./One_Install_Samba.sh
   ```
![一键安装](https://github.com/danyanp/One_Install_Samba/blob/master/root.png?raw=true)
## 2.原理
```
#step1
#先安装，避免网络无法下载
if [ `whoami` != "root" ];then
        echo "请切换roo用户，su 密码super0！！！"
        exit
fi

#step2
rpm -q samba
rpm -e samba
echo "5秒后开始安装"
sleep 5
yum -y install samba
echo "samba安装成功"

#step3
#关闭防火墙
#设置ip为同一个网段
service iptables stop
read -p "查看VMnet8，输入ip地址:" address
read -p "请输入配置网卡:" eth
ifconfig ${eth} ${address}
echo "网络配置成功"

#step4
#添加用户
read -p "请输入用户名" username
useradd ${username}
smbpasswd -a ${username}
echo "samba添加用户成功"
service smb start
setenforce 0
service smb restart
echo "samba重启成功"
echo "安装完毕，在win7输入\\$address"

```