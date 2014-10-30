common
=========

The common role includes tasks meant for all servers. Here is a quick breakdown of what is intended to happen with the common role.

Role Variables
--------------

Variables for all roles have been moved to the root group_vars/all.

     # hostname of the controller, mapped in /etc/hosts
     CONTROLLER: controller.domain.com

     # mysql admin db password
     MYSQL_ADMIN_PASS: password
