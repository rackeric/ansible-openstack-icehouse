#!/bin/sh

# change OS_SERVICE_TOKEN, admin password and demo password

export OS_SERVICE_TOKEN=a1s2d3f4g5h6j7k8
export OS_SERVICE_ENDPOINT=http://controller:35357/v2.0

keystone user-create --name=admin --pass=admin --email=admin@domain.com
keystone role-create --name=admin
keystone tenant-create --name=admin --description="Admin Tenant"
keystone user-role-add --user=admin --tenant=admin --role=admin
keystone user-role-add --user=admin --role=_member_ --tenant=admin

keystone user-create --name=demo --pass=demo --email=demo@domain.com
keystone tenant-create --name=demo --description="Demo Tenant"
keystone user-role-add --user=demo --role=_member_ --tenant=demo
keystone tenant-create --name=service --description="Service Tenant"

keystone service-create --name=keystone --type=identity   --description="OpenStack Identity"
keystone endpoint-create   --service-id=$(keystone service-list | awk '/ identity / {print $2}')   --publicurl=http://controller:5000/v2.0   --internalurl=http://controller:5000/v2.0   --adminurl=http://controller:35357/v2.0
