variable "image" {
  default = "local/dublin_bus_telegram_bot"
}

provider "docker" {
    host = "unix:///var/run/docker.sock"
}

resource "docker_container" "bot" {
  image = "${docker_image.bot.latest}"
  name = "bot"
  env = [
    "PORT=9021",
    "TELEGRAM_BOT_TOKEN=133781371:AAErpk73X1gc7q0FESV4V4DT_LbG4j1Nwk0"
  ]
  ports {
    internal = 9021
  }
}

resource "docker_image" "bot" {
    name = "${var.image}"
}

output "name" {
  value = "${docker_container.bot.name}"
}

