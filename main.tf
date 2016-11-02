provider "docker" {
    host = "unix:///var/run/docker.sock"
}

variable "TELEGRAM_BOT_TOKEN" {
  type = "string"
}

module "bot" {
  source = "./bot"
  TELEGRAM_BOT_TOKEN = "${var.TELEGRAM_BOT_TOKEN}"
  virtual_host = "bot.local"
}

module "nginx" {
  source = "nginx"
}
