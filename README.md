ansible-openstack-icehouse
==========================

Ansible playbooks to install OpenStack Icehouse RDO for CentOS

http://docs.openstack.org/icehouse/install-guide/install/yum/content/index.html

Steps to deploy
---------------
1. Set up your inventory file with a controller and compute node

2. Run: ansible-playbook -i inventory site.yml

When complete you can reach Horizon at http://1.2.3.4/dashboard using credentials admin/admin (changed in roles vars).

* Add iptables rules for port 80 and from compute to controller



Helpful Information
-------------------
The common role will update all packages and issue a reboot.  A task is present to wait 60 seconds from when seeing the server online to allowing for the server to completely boot up. Added a check to only reboot if yum update task changed anything.

The roles will search for a hidden file to confirm if the setup scripts have been ran and will not run again if found.  These are the tasks which create keystone users, services and endpoints for the other OpenStack components, imports the cirros test image in glance and creates a public and private network in neutron.

- ~/.has_keystone_setup
- ~/.has_glance_setup
- ~/.has_nova_setup
- ~/.has_neutron_setup


Following the RDO article on using Neutron with existing external network I added tasks placing the public IP address on the br-ex interface and updates neutron to allow floating IP addresses to be created on your existing network. See neutron-network role for network creation script to change for your local network.

https://openstack.redhat.com/Neutron_with_existing_external_network
