#!/bin/sh
# Fix for glance db sync fail for gmp

if [ -d ~/gmp-6.0.0 ]; 
then
  exit
fi

yum -y groupinstall "Development tools";
yum -y install gcc libgcc glibc libffi-devel libxml2-devel libxslt-devel zlib-devel bzip2-devel ncurses-devel python-devel; # openssl-devel was not working

wget https://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.bz2
tar -xvjpf gmp*
cd gmp-6.0.0
./configure
make
make check
make install

#pip install --ignore-installed PyCrypto #shit doesn't work anymore

mkdir ~/back
mv /usr/lib64/libgmp* ~/back/
#cp /usr/local/lib/libgmp* /usr/lib64/
ln -s /usr/local/lib/libgmp.so.10.2.0 /usr/lib64/libgmp.so
ln -s /usr/local/lib/libgmp.so.10.2.0 /usr/lib64/libgmp.so.10
