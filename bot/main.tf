variable "image" {
  default = "local/dublin_bus_telegram_bot"
}

variable "port" {
  default = 9568
}

variable "TELEGRAM_BOT_TOKEN" {
  type = "string"
}

variable "virtual_host" {
  type = "string"
}

provider "docker" {
    host = "unix:///var/run/docker.sock"
}

resource "docker_container" "bot" {
  image = "${docker_image.bot.latest}"
  name = "bot"
  env = [
    "PORT=${var.port}",
    "TELEGRAM_BOT_TOKEN=${var.TELEGRAM_BOT_TOKEN}",
    "VIRTUAL_HOST=${var.virtual_host}"
  ]
  ports {
    internal = "${var.port}"
  }
}

resource "docker_image" "bot" {
    name = "${var.image}"
}

output "name" {
  value = "${docker_container.bot.name}"
}

