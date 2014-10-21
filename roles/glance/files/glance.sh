#!/bin/sh
#
# Install OpenStack Glance services
# http://docs.openstack.org/icehouse/install-guide/install/yum/content/glance-install.html
#

GLANCE_PASS="glance"
CONTROLLER="controller"

export OS_SERVICE_TOKEN=a1s2d3f4g5h6j7k8
export OS_SERVICE_ENDPOINT=http://$CONTROLLER:35357/v2.0

# glance db sync
# moving to playbook task
#su -s /bin/sh -c "glance-manage db_sync" glance

# Step 5

keystone user-create --name=glance --pass=$GLANCE_PASS --email=eric@empulsegroup.com;
keystone user-role-add --user=glance --tenant=service --role=admin;

# Step 6
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_uri http://$CONTROLLER:5000;
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_host $CONTROLLER;
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_port 35357;
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_protocol http;
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken admin_tenant_name service;
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken admin_user glance;
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken admin_password $GLANCE_PASS;
openstack-config --set /etc/glance/glance-api.conf paste_deploy flavor keystone;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_uri http://$CONTOLLER:5000;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_host $CONTROLLER;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_port 35357;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_protocol http;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken admin_tenant_name service;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken admin_user glance;
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken admin_password $GLANCE_PASS;
openstack-config --set /etc/glance/glance-registry.conf paste_deploy flavor keystone;

# Step 7
keystone service-create --name=glance --type=image --description="OpenStack Image Service";keystone endpoint-create --service-id=$(keystone service-list | awk '/ image / {print $2}') --publicurl=http://$CONTROLLER:9292 --internalurl=http://$CONTROLLER:9292 --adminurl=http://$CONTROLLER:9292;

# Step 8
service openstack-glance-api start;service openstack-glance-registry start;chkconfig openstack-glance-api on;chkconfig openstack-glance-registry on;

