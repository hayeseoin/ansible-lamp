# ansible-lamp

# Deploying the playbook

The following command will deploy this playbook locally.
`ansible-playbook -i "localhost," -c local site.yml`

This will deploy the playbook remotely.
`ansible-playbook -i '192.168.1.10,' site.yaml -u ec2-user`

# Apache and PHP

PHP must be installed *after* PHP, as PHP has notify tasks to restart Apache.


