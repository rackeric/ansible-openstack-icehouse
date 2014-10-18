#!/bin/sh


# Step 2
openstack-config --set /etc/nova/nova.conf database connection mysql://nova:nova@controller/nova;
openstack-config --set /etc/nova/nova.conf DEFAULT auth_strategy keystone;
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_uri http://controller:5000;
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_host controller;
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_protocol http;
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_port 35357;
openstack-config --set /etc/nova/nova.conf keystone_authtoken admin_user nova;
openstack-config --set /etc/nova/nova.conf keystone_authtoken admin_tenant_name service;
openstack-config --set /etc/nova/nova.conf keystone_authtoken admin_password nova;

# Step 3
openstack-config --set /etc/nova/nova.conf DEFAULT rpc_backend qpid;
openstack-config --set /etc/nova/nova.conf DEFAULT qpid_hostname controller;

# Step 4
openstack-config --set /etc/nova/nova.conf DEFAULT my_ip 192.168.1.112;
openstack-config --set /etc/nova/nova.conf DEFAULT vnc_enabled True;
openstack-config --set /etc/nova/nova.conf DEFAULT vncserver_listen 0.0.0.0;
openstack-config --set /etc/nova/nova.conf DEFAULT vncserver_proxyclient_address 192.168.1.110;
openstack-config --set /etc/nova/nova.conf DEFAULT novncproxy_base_url http://controller:6080/vnc_auto.html;

# Step 5
openstack-config --set /etc/nova/nova.conf DEFAULT glance_host controller;

# Step 6
#$ egrep -c '(vmx|svm)' /proc/cpuinfoIf 0 then,
# openstack-config --set /etc/nova/nova.conf libvirt virt_type qemu

# Step 7
service libvirtd start;
service messagebus start;
service openstack-nova-compute start;
chkconfig libvirtd on;
chkconfig messagebus on;
chkconfig openstack-nova-compute on;
