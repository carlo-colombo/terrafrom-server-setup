provider "docker" {
    host = "unix:///var/run/docker.sock"
}

variable "dublin_bus_bot_token" {
  type = "string"
}

module "bot" {
  source = "./bot"
  dublin_bus_bot_token = "${var.dublin_bus_bot_token}"
  virtual_host = "bot.local"
}

module "nginx" {
  source = "nginx"
}

output "containers" {
  value = [ "${module.bot.values}" ]
}
