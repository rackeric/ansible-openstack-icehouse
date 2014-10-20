ansible-openstack-icehouse
==========================

Ansible playbooks to install OpenStack Icehouse RDO for CentOS

http://docs.openstack.org/icehouse/install-guide/install/yum/content/index.html

Steps to deploy
---------------
1. Set up your inventory file with a controller and compute node

2. Run site.yml

$ time ansible-playbook site.yml

When complete you can reach Horizon at http://<ip address>/dashboard using credentials admin/admin (changed in roles vars).

* Add iptables rules for port 80 and from compute to controller

