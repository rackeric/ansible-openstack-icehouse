#!/bin/sh

NOVA_PASS="nova"
CONTROLLER="controller"
EMAIL="me@domain.com"

export OS_USERNAME=admin
export OS_PASSWORD=admin
export OS_TENANT_NAME=admin
export OS_AUTH_URL=http://$CONTROLLER:35357/v2.0

# Step 7
keystone user-create --name=nova --pass=$NOVA_PASS --email=$EMAIL;
keystone user-role-add --user=nova --tenant=service --role=admin;

# Step 8
openstack-config --set /etc/nova/nova.conf DEFAULT auth_strategy keystone;
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_uri http://$CONTROLLER:5000;
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_host $CONTROLLER;
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_protocol http;
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_port 35357;
openstack-config --set /etc/nova/nova.conf keystone_authtoken admin_user nova;
openstack-config --set /etc/nova/nova.conf keystone_authtoken admin_tenant_name service;
openstack-config --set /etc/nova/nova.conf keystone_authtoken admin_password $NOVA_PASS;

# Step 9
keystone service-create --name=nova --type=compute --description="OpenStack Compute";
keystone endpoint-create --service-id=$(keystone service-list | awk '/ compute / {print $2}') --publicurl=http://$CONTROLLER:8774/v2/%\(tenant_id\)s --internalurl=http://$CONTROLLER:8774/v2/%\(tenant_id\)s --adminurl=http://$CONTROLLER:8774/v2/%\(tenant_id\)s;
