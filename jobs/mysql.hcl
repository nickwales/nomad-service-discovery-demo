job "mysql-server" {

    datacenters = ["dc1"]
    type        = "service"

    constraint {
        attribute = "${attr.cpu.arch}"
        value = "amd64"
    }

    group "mysql-server" {
        count = 1

        network {
            port "db" {
                static = 3306
                to     = 3306
            }
        }

        restart {
            attempts = 10
            interval = "5m"
            delay    = "25s"
            mode     = "delay"
        }

        task "mysql-server" {
            driver = "docker"

            env = {
                MYSQL_DATABASE = "wordpress"
                MYSQL_USER = "wordpress"
                MYSQL_PASSWORD = "highlysecurepassword"
                MYSQL_RANDOM_ROOT_PASSWORD = "1"
            }

            config {
                image = "mysql"
                ports = ["db"]
            }

            resources {
                cpu    = 250
                memory = 450
            }

            service {
                provider = "nomad"
                
                name = "mysql-server"
                port = "db"  
                tags = ["mysql", "wordpress", "demo"]      
            }
        }
    }
}