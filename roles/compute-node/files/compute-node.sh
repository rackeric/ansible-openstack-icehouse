#!/bin/sh

MY_IP=`ifconfig eth0 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`
ADMIN_USER="nova"
ADMIN_PASS="nova"
CONTROLLER="controller"

# Step 2
openstack-config --set /etc/nova/nova.conf database connection mysql://$ADMIN_USER:$ADMIN_PASS@$CONTROLLER/nova;
openstack-config --set /etc/nova/nova.conf DEFAULT auth_strategy keystone;
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_uri http://$CONTROLLER:5000;
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_host $CONTROLLER;
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_protocol http;
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_port 35357;
openstack-config --set /etc/nova/nova.conf keystone_authtoken admin_user $ADMIN_USER;
openstack-config --set /etc/nova/nova.conf keystone_authtoken admin_tenant_name service;
openstack-config --set /etc/nova/nova.conf keystone_authtoken admin_password $ADMIN_PASS;

# Step 3
openstack-config --set /etc/nova/nova.conf DEFAULT rpc_backend qpid;
openstack-config --set /etc/nova/nova.conf DEFAULT qpid_hostname $CONTROLLER;

# Step 4
openstack-config --set /etc/nova/nova.conf DEFAULT my_ip $MY_IP;
openstack-config --set /etc/nova/nova.conf DEFAULT vnc_enabled True;
openstack-config --set /etc/nova/nova.conf DEFAULT vncserver_listen 0.0.0.0;
openstack-config --set /etc/nova/nova.conf DEFAULT vncserver_proxyclient_address $MY_IP;
openstack-config --set /etc/nova/nova.conf DEFAULT novncproxy_base_url http://$CONTROLLER:6080/vnc_auto.html;

# Step 5
openstack-config --set /etc/nova/nova.conf DEFAULT glance_host $CONTROLLER;

# Step 6
if [ $(egrep -c '(vmx|svm)' /proc/cpuinfo) -eq 0 ]
  then
    openstack-config --set /etc/nova/nova.conf libvirt virt_type qemu
fi

# Step 7
service libvirtd start;
service messagebus start;
service openstack-nova-compute start;
chkconfig libvirtd on;
chkconfig messagebus on;
chkconfig openstack-nova-compute on;
