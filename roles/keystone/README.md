keystone
=========

The keystone role includes tasks meant for the OpenStack controller node. Here is a quick breakdown of what is intended to happen with the keystone role.

Role Variables
--------------

Variables for all roles have been moved to the root group_vars/all.

     # hostname of the controller, mapped in /etc/hosts
     CONTROLLER: controller

     # email addressed used for keystone services
     EMAIL: me@domain.com

     # keystone users passwords
     ADMIN_PASS: admin
     DEMO_PASS: demo

     # keystone vars
     KEYSTONE_DBPASS: keystone
     ADMIN_TOKEN: a1s2d3f4g5h6j7k8     
