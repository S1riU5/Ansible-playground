#Prerequisites

In order to execute the playbook `playbook.yaml`, we need two VM's
Both have to be reachable via ssh with the root user aswell as with a second ubuntu user. To achive this, attache you'r public ssh key to the following two files:
/root/.ssh/authorized_keys
/home/ubuntu/authorized_keys
either via:
ssh-copy-id -i ~/.ssh/<ssh-key> <username>@<host>

or by adding the keys manually to the /home/.ssh/authorized_keys.


## Required Software
The script is tested with the following software versions:

* Python 3.10.2
* ansible [core 2.12.2]
* ansibel galaxy collections:
    * community.crypto
    * community.docker


# playbook.yaml

The playbook.yaml can be used to build and instnstall the Dockerfile in the project root.
The dockerfile contains a ssh server bound to port 2025. The goal of the script is to install the 
docker container plus all requirements on all ansible hosts. 
To run the ansible script, run the following command:
```
ansible-playbook playbook.yaml -i inventory --private-key=./rsa_id -u ubuntu  -e 'ansible_python_interpreter=/usr/bin/python3'
```

After the script executed successfully, one can ssh into the docker container inside the VM with the following command:
```
ssh root@<VM-Ip> -p 2025 -i ./rsa_id
```

to connect to the docker container inside the VM and 

```
ssh root@<VM-Ip> -i ./rsa_id
```

to connect to the VM.

## Known issues
At the moment the ssh connection to the docker container with the ubuntuuser does not work without the password.
The reason for this is at the moment, the owner of `/home/ubuntu/.ssh/authorized_keys` is root. To fix this we have to change the owner inside the Docker file or add a ansible step to change the permission.