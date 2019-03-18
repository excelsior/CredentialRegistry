FROM ubuntu
MAINTAINER Alex Nizamov <alex@learningtapestry.com>

# Ansible
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:ansible/ansible
RUN apt-get update
RUN apt-get install -y ansible

# Configure locale
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Copy and run playbook
ADD ansible/inventory /etc/ansible/hosts
ADD ansible/data/ /etc/data/
ADD ansible/playbooks/ /etc/ansible/
ADD ansible/templates/ /etc/templates/
WORKDIR /etc/ansible
RUN ansible-playbook /etc/ansible/main.yml -c local
