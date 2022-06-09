##  Nomad Service Discovery Demo

### Instructions

- Start up the VM

`vagrant up`

Once complete, Nomad should be available at http://localhost:4646
The services API is available at http://localhost:4646/services

- Start the loadbalancer

`nomad job run jobs/traefik`

The dashboard is available at http://localhost:8080/dashboard/

- Start wordpress

`nomad job run jobs/wordpress`

- Start mysql

`nomad job run jobs/mysql`