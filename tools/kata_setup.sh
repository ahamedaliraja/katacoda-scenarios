#!/bin/bash -ex

ANSIBLE_CORE=2.21.4
MOLECULE=26.9.0
MOLECULE_DOCKER=1.0.2
ANSIBLE_LINT=26.9.0
YAML_LINT=1.38.0
DOCKER_PY=6.1.1

DOCKER_COLLECTION=3.10.4
CRYPT_COLLECTION=1.7.1
GENERAL_COLLECTION=3.8.0

apt install -y python3-pip tree

pip install -U pip setuptools
pip install \
    ansible-core==${ANSIBLE_CORE} \
    molecule==${MOLECULE} \
    molecule-docker==${MOLECULE_DOCKER} \
    ansible-lint==${ANSIBLE_LINT} \
    yamllint==${YAML_LINT} \
    docker==${DOCKER_PY}
apt install -y docker.io
hash -r
ansible-galaxy collection install community.docker:${DOCKER_COLLECTION}
ansible-galaxy collection install community.crypto:${CRYPT_COLLECTION}
ansible-galaxy collection install community.general:${GENERAL_COLLECTION}

ansible --version
ansible-galaxy collection list

ansible-playbook -i kata_inventory kata_prepare.yml

cp -r ../materials/working /root/working

echo "### setup complete"
ansible --version
ansible-galaxy collection list
ansible-lint --version
molecule --version
