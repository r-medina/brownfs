#!/bin/bash

set -e

echo "apt-get update..."
sudo apt-get update &>/dev/null
echo "apt-get upgrade..."
$(sudo apt-get upgrade -y &>/dev/null; RETVAL=0)

[[ -a /vagrant/.uname ]] && uname=$(cat /vagrant/.uname)
[[ -z ${uname} ]] && echo "run init USERNAME" && return 1;

echo "symlinking course and ${uname}..."
[[ ! -h /course ]] && sudo ln -s /vagrant/course /course
[[ ! -h /home/${uname} ]] && sudo ln -s /vagrant/home/${uname} /home/${uname}

[[ -z $LOGINCD ]] && echo "cd /home/${uname}; export LOGINCD=1" >> /home/vagrant/.bashrc && export LOGINCD=1
