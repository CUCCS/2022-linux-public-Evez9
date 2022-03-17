#   实验目的与自评 

    建立Linux服务器系统使用基础，熟悉文件的压缩与解压缩、软件包管理、文件管理、进程管理、目录结构、网络调试的方法。  
    本次实验自评7分，能够认真完成每项操作。  


#   实验步骤与结果    

**实验环境** 用 主机的git bash 远程登陆 虚拟机中下载的老师给的百度云链接 Linux Ubuntu20.04 以及 阿里云提供的Linux指令入门操作平台  

**asciinema主页** [my profile](https://asciinema.org/~zyy-9 "my profile")  

##  【软件包管理】  

### 安装 tmux 和 tshark  
    Ubuntu： 
        sudo apt-get install tshark  
        sudo apt-get install tmux  

    CenOS：   
        sudo yum install tmux    
        yum install -y epel-release  
        yum install -y wireshark  

### 查看这 2 个软件被安装到哪些路径；  
    whereis tmux  
    whereis tshark  

### 卸载 tshark ：  
    Ubuntu： sudo apt-get remove tshark    
    CenOS：  sudo yum remove tshark  

### 验证 tshark 卸载结果  
    ls /usr/bin/tshark  

#### 该实验的asciinema的分享URL  
[package_management Ubuntu](https://asciinema.org/a/476534 "package_management Ubuntu")    
[package_management CentOS](https://asciinema.org/a/476864 "package_management CentOS")  


##  【文件管理】  

### 复制代码后 找到 /tmp 目录及其所有子目录下，文件名包含 666 的所有文件  
    find / -name *666*  

### 找到 /tmp 目录及其所有子目录下，文件内容包含 666 的所有文件  
    grep -r "666" ./  

#### 该实验的asciinema的分享URL  
[file_management Ubuntu](https://asciinema.org/a/476574 "file_management Ubuntu")    
[file_management CentOS](https://asciinema.org/a/476867 "file_management CentOS")  


## 【文件压缩与解压缩】  

    首先创建文件 test.txt  
    接着下载系统不自带的压缩、解压缩软件  
    然后逐个对 test.txt 进行压缩、解压缩操作  

    gzip test.txt  
    gzip -d test.txt.gz  

    bzip2 test.txt  
    bzip2 -d test.txt.bz2  

    zip zyy.zip test.txt  
    unzip zyy.zip  
 
    tar -czcf test.txt.tar.gz test.txt  
    tar -xzvf test.txt.tar.gz  

    7z a h2.7z test.txt  
    7z x h2.7z  

    rar a file.rar test.txt  
    rar a h2.rar test.txt  

#### 该实验的asciinema的分享URL  
[zip_unzip Ubuntu](https://asciinema.org/a/476855 "zip_unzip Ubuntu")    
[zip_unzip CentOS](https://asciinema.org/a/476884 "zip_unzip CentOS")  


##  【跟练】  
    以下是视频中的命令与其作用：  

    ping www.baidu.com 测试本机与目标主机的联通性、联通速度、稳定性  
    CTRL C 终止命令  

    ping www.baidu.com &  
    此时CTRL C无法终止命令 需要打开另外一个终端 输入命令ps aux |grep ping 再kill 所显示编号 回到原来的终端再CTRL C  (如下图)
![kill_ping &](/img/kill_ping%20%26.jpg "kill_ping &")

    ping www.baidu.com 1>/dev/null 2>&1 &  

    ifconfig 显示网络设备状态  

    uname -a 显示操作系统的所有信息  

    lsb_release -a 查询版本信息  

    ps aux |grep ping 显示所有进程及其状态  

    fg 将后台运行的或挂起的任切换到前台运行  

    CTTL Z 暂停程序运行  

    killall ping 杀死该进程  

    kill 杀死该进程 但并非强制 有失败的可能  

    kill -9 强制终止  

    pstree -A 显示正在运行的进程的进程树  

#### 该实验的asciinema的分享URL  
[following_practice Ubuntu](https://asciinema.org/a/476640 "following_practice Ubuntu")    
[following_practice CentOS](https://asciinema.org/a/476874 "following_practice CentOS")  


##  【硬件信息获取】  

### 目标系统的 CPU  
    cat /proc/cpuinfo  

### 内存大小  
    cat /proc/meminfo  

### 硬盘数量  
    df -l  

### 硬盘容量  
    df -h  

#### 该实验的asciinema的分享URL  
[access_to_hardware-information Ubuntu](https://asciinema.org/a/476579 "access_to_hardware-information Ubuntu")    
[access_to_hardware-information CentOS](https://asciinema.org/a/476871 "access_to_hardware-information CentOS")  


#   问题分析与解决      

1.  权限问题    
    实验中的有些操作需要**管理员权限**     
    若不在最前面加sudo就会出现如图所示的 permission denied的问题 
    解决方法：以管理员身份发出指令   
    ![permission denied](/img/permission_denied.jpg "permission denied")   

2.  CentOS中软件安装问题  
    有些软件在CentOS中没有安装包(no package *** available)
    需要通过其他方式进行下载安装  

    如tshark  
    ![tshark_download_problem](/img/tshark_download_problem.jpg "tshark_download")  
    解决方法：
    首先安装epel扩展源: yum install -y epel-release
    接着安装wireshark: yum install -y wireshark
    最后查看tshark版本: tshark -v
    ![install_epel](/img/tshark_download_solution_step1.jpg "install_epel")
    ![install_wirechark&check_tshark](/img/tshark_download_solution_step2.jpg "install_wirechark&check_tshark")

    如rar  
    ![rar_download_problem](/img/rar_download_problem.jpg "rar_download_problem")  
    解决方法：
    **首先进行*更新***： sudo yum update
    接着从官网上下载压缩包： wget http://www.rarlab.com/rar/rarlinux-x64-4.2.0.tar.gz
    最后解压缩： tar zxvf rarlinux-x64-4.2.0.tar.gz
    ![rar_download_solution](/img/rar_download_solution.jpg "rar_download_solution")  
   

#   参考链接      
 
【CentOS中软件安装问题】参考   
[Linux之tshark抓包工具安装和使用](https://blog.csdn.net/carefree2005/article/details/122131633)  
[CentOS用yum指令安装rar](https://zhidao.baidu.com/question/542891191.html)  

【文件管理】实验参考   
[linux查找包含指定文件名的文件位置/找包含指定内容的文件位置/找文件中的指定内容](https://blog.csdn.net/HYZX_9987/article/details/105514175)  

【硬件信息获取】实验参考   
[linux 查看cpu核数、内存总容量、硬盘总容量](https://blog.csdn.net/JineD/article/details/107611133)  