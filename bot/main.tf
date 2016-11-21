variable "image" {
  default = "local/dublin_bus_telegram_bot"
}

variable "name" {
  type = "string"
}

variable "virtual_host_suffix" {
  default = "local.dev"
}

variable "port" {
  default = 9568
}

variable "bot_token" {
  type = "string"
}

variable "env_vars" {
  default = []
}

resource "docker_container" "bot" {
  image = "${var.image}"
  name = "${var.name}"
  env = "${concat(split(",","PORT=${var.port},TELEGRAM_BOT_TOKEN=${var.bot_token},VIRTUAL_HOST=${var.name}.${var.virtual_host_suffix},BASE_ADDRESS=http://${var.name}.${var.virtual_host_suffix}"),var.env_vars)}"
  ports {
    internal = "${var.port}"
  }
}


output "values" {
  value = {
    name = "${docker_container.bot.name}"
    status = "http://${var.name}.${var.virtual_host_suffix}/${var.bot_token}/status"
  }
}

