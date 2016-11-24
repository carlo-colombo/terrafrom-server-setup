provider "docker" {
    host = "unix:///var/run/docker.sock"
}

variable "webhook_me_bot_token" {
  type = "string"
}

variable "dublin_bus_bot_token" {
  type = "string"
}

variable "hashids_salt" {
  type = "string"
}

module "dublin_bus" {
  source = "./bot"
  name = "dublin_bus"
  image = "carlocolombo/dublin_bus_telegram_bot"
  bot_token = "${var.dublin_bus_bot_token}"
}

module "webhook_me" {
  source = "./bot"
  name = "webhook_me"
  image = "carlocolombo/webhook_me"
  bot_token = "${var.webhook_me_bot_token}"
  env_vars = [
    "HASHIDS_SALT=${var.hashids_salt}"
  ]
}

module "nginx" {
  source = "nginx"
}

output "containers" {
  value = [
    "${module.dublin_bus.values}",
    "${module.webhook_me.values}"
  ]
}
