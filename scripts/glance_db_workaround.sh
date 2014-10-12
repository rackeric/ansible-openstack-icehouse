#!/bin/sh
#
# Install OpenStack Glance services
# http://docs.openstack.org/icehouse/install-guide/install/yum/content/glance-install.html
#

GLANCE_PASS="glance"

# Fix for glance db sync fail for gmp

yum -y groupinstall "Development tools";
yum -y install gcc libgcc glibc libffi-devel libxml2-devel libxslt-devel zlib-devel bzip2-devel ncurses-devel; # openssl-devel was not working

wget https://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.bz2
tar -xvjpf gmp*
cd gmp*
./configure
make
make check
make install

#pip install --ignore-installed PyCrypto #shit doesn't work anymore

mkdir ~/back
mv /usr/lib64/libgmp* ~/back/
cp /usr/local/lib/libgmp* /usr/lib64/

su -s /bin/sh -c "glance-manage db_sync" glance

