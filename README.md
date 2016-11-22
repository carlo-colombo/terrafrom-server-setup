# terrafrom-server-setup

## Objective
Recreating with [terraform](https://www.terraform.io) a setup I already have with `docker-compose`. The setup consist of `nginx` acting as reverse proxy in front of a couple of different webservices (1 static website, 2 telegram bot, 1 rest service). Additionally `https` is provided with `letsencrypt`. All the services are deployed as docker images, plus there is a docker image that host nginx (and another that provide the letsencrypt certificates). Request on the port `80` of the webserver will be dispatched to the relevenat webservice based on the `Host` header.

### Actual situation
`docker-compose` allow to spin up a set of images based on a yaml configuration fiele (yeah yaml!!! :-D ). `docker-compose` does not implement (AFAIK) any type of templating in its configuration file this bring duplication and embedding of secrets inside of the configuration.

### [nginx-proxy](https://github.com/jwilder/nginx-proxy)
nginx-proxy sets up a container running nginx and docker-gen. docker-gen generates reverse proxy configs for nginx and reloads nginx when containers are started and stopped.
