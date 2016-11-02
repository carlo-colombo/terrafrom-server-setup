variable "port" {
  default = 9568
}

provider "docker" {
    host = "unix:///var/run/docker.sock"
}

resource "docker_container" "nginx" {
  image = "${docker_image.nginx.latest}"
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

resource "docker_image" "nginx" {
    name = "jwilder/nginx-proxy"
}

