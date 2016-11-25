# terrafrom-server-setup

## Objective
Recreating with [terraform](https://www.terraform.io) a setup I already have with `docker-compose`. The setup consist of `nginx` acting as reverse proxy in front of a couple of different webservices (1 static website, 2 telegram bot, 1 rest service). Additionally `https` is provided with `letsencrypt`. All the services are deployed as docker images, plus there is a docker image that host nginx (and another that provide the letsencrypt certificates). Request on the port `80` of the webserver will be dispatched to the relevenat webservice based on the `Host` header.

### Actual situation
`docker-compose` allow to spin up a set of images based on a yaml configuration fiele (yeah yaml!!! :-D ). `docker-compose` does not implement (AFAIK) any type of templating in its configuration file this bring duplication and embedding of secrets inside of the configuration.

### Expected improvment using Terraform
- configuration reusability between similar services (bots)
- removing secrets from the configuration
- terraform output can be used to automate succesful step (eg ping to `/status` endpoint )

### [nginx-proxy](https://github.com/jwilder/nginx-proxy)
nginx-proxy sets up a container running nginx and docker-gen. docker-gen generates reverse proxy configs for nginx and reloads nginx when containers are started and stopped.



### Prepare

#### pull docker images 
```
> docker pull carlocolombo/dublin_bus_telegram-bot
> docker pull carlocolombo/webhook_me
> docker pull jwilder/nginx-proxy
```

#### create a `secrets.tfvars` to contain telegram bot keys and hashids salt

```
webhook_me_bot_token = "ask The Bot Father"
dublin_bus_bot_token = "ask The Bot Father"
hashids_salt =  "a random string"
```

### Terraform commands

```
# See the resource that terraform is planning to create
> terraform plan -var-file=secrets.tfvars

# Create and run the containers
> terraform apply -var-file=secrets.tfvars

# Tear down everything
> terraform destroy -var-file=secrets.tfvars
```
