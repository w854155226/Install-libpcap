# check root
[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1

# check os
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    echo -e "${red}未检测到系统版本，请联系脚本作者！${plain}\n" && exit 1
fi

arch=$(arch)

if [[ $arch == "x86_64" || $arch == "x64" || $arch == "amd64" ]]; then
    arch="amd64"
elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
    arch="arm64"
elif [[ $arch == "s390x" ]]; then
    arch="s390x"
else
    arch="amd64"
    echo -e "${red}检测架构失败，使用默认架构: ${arch}${plain}"
fi

echo "架构: ${arch}"

if [ $(getconf WORD_BIT) != '32' ] && [ $(getconf LONG_BIT) != '64' ]; then
    echo "本软件不支持 32 位系统(x86)，请使用 64 位系统(x86_64)，如果检测有误，请联系作者"
    exit -1
fi

os_version=""

# os version
if [[ -f /etc/os-release ]]; then
    os_version=$(awk -F'[= ."]' '/VERSION_ID/{print $3}' /etc/os-release)
fi
if [[ -z "$os_version" && -f /etc/lsb-release ]]; then
    os_version=$(awk -F'[= ."]+' '/DISTRIB_RELEASE/{print $2}' /etc/lsb-release)
fi
elif [[ x"${release}" == x"ubuntu" ]]; then
    if [[ ${os_version} -lt 18 ]]; then
        echo -e "${red}请使用 Ubuntu 18 或更高版本的系统！${plain}\n" && exit 1
fi

install_base() {
    if [[ x"${release}" == x"centos" ]]; then
        yum install wget curl tar -y
    else
        apt install wget curl tar -y
    fi
}

wget -qO- https://github.com/w854155226/Install-libpcap-script/raw/main/Install.sh
chmod +x /root/Install.sh
mkdir asscan
cd asscan
wget https://github.com/w854155226/Install-libpcap-script/raw/main/asscan/asscan.sh
wget https://github.com/w854155226/Install-libpcap-script/raw/main/asscan/goscan
wget https://github.com/w854155226/Install-libpcap-script/raw/main/asscan/masscan
chmod +x asscan.sh
cd
sudo apt-get install libpcap-dev libnids-dev libnet1-dev
wget https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.gz
sudo tar -zxvf m4-1.4.19.tar.gz
cd m4-1.4.19.tar.gz
sudo ./configure
sudo make
sudo make install
cd
sudo apt-get install flex
sudo apt-get install bison
wget https://www.tcpdump.org/release/libpcap-1.10.3.tar.gz
tar -zxvf libpcap-1.10.3.tar.gz
cd libpcap-1.10.3
sudo ./configure
sudo make
sudo make install
find /usr -name "libpcap*so*"
cd
cd asscan
./asscan.sh
