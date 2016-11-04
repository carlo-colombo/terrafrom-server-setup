variable "image" {
  default = "local/dublin_bus_telegram_bot"
}

variable "port" {
  default = 9568
}

variable "dublin_bus_bot_token" {
  type = "string"
}

variable "virtual_host" {
  type = "string"
}

resource "docker_container" "bot" {
  image = "${var.image}:latest"
  name = "${var.virtual_host}"
  env = [
    "PORT=${var.port}",
    "TELEGRAM_BOT_TOKEN=${var.dublin_bus_bot_token}",
    "VIRTUAL_HOST=${var.virtual_host}"
  ]
  ports {
    internal = "${var.port}"
  }
}

output "values" {
  value = {
    name = "${docker_container.bot.name}"
  }
}

