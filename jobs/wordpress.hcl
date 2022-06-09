job "wordpress-server" {
    datacenters = ["dc1"]
    type        = "service"

    group "wordpress-server" {
        count = 1

        network {
            port "wordpress" {
                to = 80
            }
        }        

        task "wordpress-server" {
            driver = "docker"

            template {
                destination = "local/wp-config.env"
                env         = true
                change_mode = "restart"
                data = <<EOH
WORDPRESS_DB_NAME = "wordpress"
WORDPRESS_DB_USER = "wordpress"
WORDPRESS_DB_PASSWORD = "highlysecurepassword"

{{ range nomadService "mysql-server" }}
WORDPRESS_DB_HOST = {{ .Address }}:{{ .Port }}
{{ end }}
EOH
            }      

            config {
                image = "wordpress"
                ports = ["wordpress"]
            }

            resources {
                cpu    = 190
                memory = 128
            }

            service {
                provider = "nomad"
                
                name = "wordpress-server"
                tags = [
                    "traefik.enable=true",
                    "traefik.http.routers.wordpress.rule=Host(`localhost`)"
                ]
                port = "wordpress"
            }
        }
    }
}