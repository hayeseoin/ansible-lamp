# ansible-lamp
testing ansible for deploying lamp

Must be run in ansible venv
`source /opt/ansible-venv/bin/activate`

The following command will deploy the local playbooks
`ansible-playbook -i "localhost," -c local your-playbook.yaml`

Or remotely
`ansible-playbook -i '192.168.1.10,' site.yaml -u ec2-user --private-key ~/.ssh/key.pem`

