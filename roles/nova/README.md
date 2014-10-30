nova
=========

The nova role includes tasks meant for the OpenStack controller node. Here is a quick breakdown of what is intended to happen with the nova role.

Role Variables
--------------

Variables for all roles have been moved to the root group_vars/all.

     # hostname of the controller, mapped in /etc/hosts
     CONTROLLER: controller.domain.com

     # email addressed used for keystone services
     EMAIL: me@domain.com

     # nova vars
     NOVA_DBPASS: nova
     NOVA_ADMIN_PASS: nova
     MY_IP: "{{ ansible_eth1.ipv4.address }}"
