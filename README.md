# Passbolt CE on Fly.io

## MySQL App

see: https://fly.io/docs/app-guides/mysql-on-fly/

more info about volumes: https://fly.io/docs/reference/volumes/

connect from local machine: https://fly.io/docs/laravel/the-basics/databases/#connect-from-a-local-environment


### Required Secrets

- `MYSQL_PASSWORD`
- `MYSQL_ROOT_PASSWORD`


## Passbolt App

inspired by:
- https://fly.io/docs/app-guides/mysql-on-fly/
- https://github.com/passbolt/passbolt_docker/blob/master/docker-compose/docker-compose-ce.yaml

config reference: https://fly.io/docs/reference/configuration

ports that passbolt uses: https://help.passbolt.com/faq/hosting/firewall-rules


### Required Secrets

- `DATASOURCES_DEFAULT_PASSWORD`


### Creating first admin user

see: https://help.passbolt.com/hosting/install/ce/docker.html

1. `fly ssh console`
2. `cd /usr/share/php/passbolt/bin`
3. `./cake passbolt register_user -u <email address> -f <first name> -l <last name> -r admin`


## Fly.io CLI Cheat Sheet

- `fly help`
- `fly help <sub-command>`
- `fly auth login`
- `fly secrets list`
- `fly volumes list`
- `fly deploy`
- `fly ssh console`


## TODO
- configure email server
- document for community