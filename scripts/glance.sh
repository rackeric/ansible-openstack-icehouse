#!/bin/sh
#
# Install OpenStack Glance services
# http://docs.openstack.org/icehouse/install-guide/install/yum/content/glance-install.html
#

GLANCE_PASS="glance"

export OS_SERVICE_TOKEN=a1s2d3f4g5h6j7k8
export OS_SERVICE_ENDPOINT=http://controller:35357/v2.0

# glance db sync
su -s /bin/sh -c "glance-manage db_sync" glance

# Step 5

keystone user-create --name=glance --pass=$GLANCE_PASS --email=eric@empulsegroup.com;
keystone user-role-add --user=glance --tenant=service --role=admin;

# Step 6
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_uri http://controller:5000;
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_host controller;
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_port 35357;
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_protocol http;
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken admin_tenant_name service;
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken admin_user glance;
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken admin_password $GLANCE_PASS;
openstack-config --set /etc/glance/glance-api.conf paste_deploy flavor keystone;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_uri http://controller:5000;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_host controller;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_port 35357;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_protocol http;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken admin_tenant_name service;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken admin_user glance;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken admin_password $GLANCE_PASS;
openstack-config --set /etc/glance/glance-registry.conf paste_deploy flavor keystone;

# Step 7
keystone service-create --name=glance --type=image --description="OpenStack Image Service";keystone endpoint-create --service-id=$(keystone service-list | awk '/ image / {print $2}') --publicurl=http://controller:9292 --internalurl=http://controller:9292 --adminurl=http://controller:9292;

# Step 8
service openstack-glance-api start;service openstack-glance-registry start;chkconfig openstack-glance-api on;chkconfig openstack-glance-registry on;


## VERIFY ##

# Step 1
mkdir /tmp/images;cd /tmp/images/;wget http://cdn.download.cirros-cloud.net/0.3.2/cirros-0.3.2-x86_64-disk.img;

# Step 2
glance image-create --name "cirros-0.3.2-x86_64" --disk-format qcow2 --container-format bare --is-public True --progress < cirros-0.3.2-x86_64-disk.img

# Step 3
glance image-list
Step 4.
rm -r /tmp/images

## CIRROS VHD ##
curl -O https://github.com/downloads/citrix-openstack/warehouse/cirros-0.3.0-x86_64-disk.vhd.tgz;
glance image-create --name cirros-vhd --container-format=ovf --disk-format=vhd < cirros-0.3.0-x86_64-disk.vhd.tgz;
rm cirros*.tgz;
