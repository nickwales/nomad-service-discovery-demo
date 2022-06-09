#!/bin/sh

## Install repo
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

## Install Nomad

apt update
apt install -y docker.io nomad 

# Configure a range of ports for dynamic workloads

$ cat <<EOF > /etc/nomad.d/port_range.hcl
client {
  min_dynamic_port = 20000
  max_dynamic_port = 20030 
}
EOF

systemctl daemon-reload
systemctl enable nomad --now
systemctl enable docker --now
