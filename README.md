ansible-openstack-icehouse
==========================

Ansible playbooks to install OpenStack Icehouse RDO for CentOS

http://docs.openstack.org/icehouse/install-guide/install/yum/content/index.html

Steps to deploy
---------------
$ ansible-playbook basic_env_config.yml # wait for reboot

$ mysql_secure_installation # on controller

$ ansible-playbook keystone.yml

$ ansible-playbook clients.yml

$ ansible-playbook glance.yml

$ ansible-playbook nova.yml
