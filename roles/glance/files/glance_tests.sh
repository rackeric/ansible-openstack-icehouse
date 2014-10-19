#!/bin/sh

CONTROLLER="controller"

## VERIFY GLANCE ##

export OS_USERNAME=admin
export OS_PASSWORD=admin
export OS_TENANT_NAME=admin
export OS_AUTH_URL=http://$CONTROLLER:35357/v2.0

# Step 1
mkdir /tmp/images;
cd /tmp/images/;
wget http://cdn.download.cirros-cloud.net/0.3.2/cirros-0.3.2-x86_64-disk.img;

# Step 2
glance image-create --name "cirros-0.3.2-x86_64" --disk-format qcow2 --container-format bare --is-public True --progress < cirros-0.3.2-x86_64-disk.img

# Step 3
glance image-list

# Step 4
rm -r /tmp/images

## CIRROS VHD ##
#curl -O https://github.com/downloads/citrix-openstack/warehouse/cirros-0.3.0-x86_64-disk.vhd.tgz;
#glance image-create --name cirros-vhd --container-format=ovf --disk-format=vhd < cirros-0.3.0-x86_64-disk.vhd.tgz;
#rm cirros*.tgz;
