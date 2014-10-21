ansible-openstack-icehouse
==========================

Ansible playbooks to install OpenStack Icehouse RDO for CentOS

http://docs.openstack.org/icehouse/install-guide/install/yum/content/index.html

Steps to deploy
---------------
1. Set up your inventory file with a controller and compute node

2. Run: ansible-playbook site.yml

When complete you can reach Horizon at http://1.2.3.4/dashboard using credentials admin/admin (changed in roles vars).

* Add iptables rules for port 80 and from compute to controller



Helpful Information
-------------------
The roles will search for a hidden file to confirm if the setup scripts have been ran and will not run again if found.  These are the tasks which create keystone users, services and endpoints for the other OpenStack components.

~/.has_keystone_setup

~/.has_glance_setup

~/.has_nova_setup

~/.has_neutron_setup
