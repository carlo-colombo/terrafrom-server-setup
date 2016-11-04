resource "docker_container" "nginx" {
  image = "jwilder/nginx-proxy"
  name = "nginx-proxy"

  ports {
    internal = 80
    external = 80
  }

  volumes {
    host_path = "/var/run/docker.sock"
    container_path = "/tmp/docker.sock"
    read_only = true
  }
}

