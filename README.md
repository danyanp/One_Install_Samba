# One_install_Samba
## 记一次 Linux 安装samba软件
> ## 实现Centos6.7一键安装samba，并实现相关功能
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

```
#step1
#关闭防火墙
#设置IP地址

service iptables stop
ifconfig eth0 192.168.5.40 netmask 255.255.255.0

#step2
#软件安装
yum -y install samba

#step3
#添加用户
mbpasswd -a danyanpi

#step4
#修改配置




```