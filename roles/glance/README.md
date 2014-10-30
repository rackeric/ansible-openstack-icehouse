glance
=========

The glance role includes tasks meant for the OpenStack controller node. Here is a quick breakdown of what is intended to happen with the glance role.

Role Variables
--------------

Variables for all roles have been moved to the root group_vars/all.

     # hostname of the controller, mapped in /etc/hosts
     CONTROLLER: controller.domain.com

     # email addressed used for keystone services
     EMAIL: me@domain.com

     # glance vars
     GLANCE_DBPASS: glance
     GLANCE_PASS: glance
