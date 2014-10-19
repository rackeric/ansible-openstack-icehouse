#!/bin/sh

NEUTRON_PASS="neutron"
CONTROLLER="controller"
EMAIL="me@domain.com"

export OS_USERNAME=admin
export OS_PASSWORD=admin
export OS_TENANT_NAME=admin
export OS_AUTH_URL=http://$CONTROLLER:35357/v2.0

keystone user-create --name neutron --pass $NEUTRON_PASS --email $EMAIL
keystone user-role-add --user neutron --tenant service --role admin
keystone service-create --name neutron --type network --description "OpenStack Networking"
keystone endpoint-create --service-id $(keystone service-list | awk '/ network / {print $2}') --publicurl http://$CONTROLLER:9696 --adminurl http://$CONTROLLER:9696 --internalurl http://$CONTROLLER:9696

