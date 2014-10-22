#!/bin/sh

CONTROLLER="controller"

export OS_USERNAME=admin
export OS_PASSWORD=admin
export OS_TENANT_NAME=admin
export OS_AUTH_URL=http://$CONTROLLER:35357/v2.0

neutron net-create ext-net --shared --router:external=True

neutron subnet-create ext-net --name ext-subnet --allocation-pool start=192.168.1.150,end=192.168.1.200 --disable-dhcp --gateway 192.168.1.254 192.168.1.0/24

neutron net-create demo-net

neutron subnet-create demo-net --name demo-subnet --gateway 10.0.0.1 10.0.0.0/24

neutron router-create demo-router

neutron router-interface-add demo-router demo-subnet

neutron router-gateway-set demo-router ext-net

