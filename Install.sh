mkdir asscan
cd asscan
sudo apt-get install libpcap-dev libnids-dev libnet1-dev
wget https://ftp.gnu.org/gnu/m4/m4-latest.tar.gz
sudo tar -zxvf m4-1.4.19
cd m4-1.4.19
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
