#!/bin/sh
##########################
## Standard Command
##########################
source /var/tmp/catalogpack_vars.txt

yum update -y
pip install ansible
yum install -y git gcc openssl-devel libffi-devel
cd ~
git clone https://github.com/shogomuranushi/c-ansible.git
##########################
## Standard Parameter
##########################
cat <<EOF > c-ansible/group_vars/all.yml
aws_region: "${aws_region}"
sshd: ${sshd}
EOF
##########################
## Wordpress Parameter
##########################
cat <<EOF > c-ansible/roles/wordpress/vars/main.yml
wp_db_name: ${db_name}
wp_db_user: ${db_user}
wp_db_password: ${db_password}
wp_dir: /var/www/html
mysql_host: ${db_host}
mysql_port: ${db_port}
auto_up_disable: false
core_update_level: true
EOF
##########################
## Ansible Exec
##########################
/usr/local/bin/ansible-playbook c-ansible/apache24+php56+wordpress.yml
