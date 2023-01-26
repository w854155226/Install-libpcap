wget -qO- https://github.com/w854155226/Install-libpcap-script/raw/main/Install.sh
chmod +x /root/Install.sh
mkdir asscan
cd asscan
wget https://github.com/w854155226/Install-libpcap-script/raw/main/asscan/asscan.sh
wget https://github.com/w854155226/Install-libpcap-script/raw/main/asscan/goscan
wget https://github.com/w854155226/Install-libpcap-script/raw/main/asscan/masscan
sudo apt-get install libpcap-dev libnids-dev libnet1-dev
chmod +x asscan.sh
cd
wget https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.gz
sudo tar -zxvf m4-1.4.19
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
