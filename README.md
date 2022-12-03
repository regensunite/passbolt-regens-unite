# Passbolt CE on Fly.io

## MySQL App

see: https://fly.io/docs/app-guides/mysql-on-fly/

more info about volumes: https://fly.io/docs/reference/volumes/

connect from local machine: https://fly.io/docs/laravel/the-basics/databases/#connect-from-a-local-environment


### Required Secrets

- `MYSQL_PASSWORD`
- `MYSQL_ROOT_PASSWORD`


### Install from Scratch

*in `mysql` folder...*

1. `fly apps create mysql-regens-unite`
2. `fly secrets set MYSQL_PASSWORD=<user password> MYSQL_ROOT_PASSWORD=<root password>`
3. `fly volumes create mysql_regens_unite --size 1`
4. `fly deploy`
5. testing...
  - `fly proxy 3306 -a mysql-regens-unite`
  - `mysql -u bb6d5879 -p -h 127.0.0.1 passbolt_1`

## Passbolt App

inspired by:
- https://fly.io/docs/app-guides/mysql-on-fly/
- https://github.com/passbolt/passbolt_docker/blob/master/docker-compose/docker-compose-ce.yaml

config reference: https://fly.io/docs/reference/configuration

ports that passbolt uses: https://help.passbolt.com/faq/hosting/firewall-rules


### Backup Procedure

see: https://help.passbolt.com/hosting/backup/from-source.html

Check out the backup script in this repo.


#### Restore MySQL Database

#TODO verify this works

1. `fly proxy 3306 -a mysql-regens-unite`
2. `mysql -u bb6d5879 -p -h 127.0.0.1 passbolt_1 < backup.sql`


### Required Secrets

- `DATASOURCES_DEFAULT_PASSWORD`
- `EMAIL_TRANSPORT_DEFAULT_PASSWORD`


### Install from Scratch

*in `passbolt` folder...*

1. `fly apps create passbolt-regens-unite`
2. `fly secrets set DATASOURCES_DEFAULT_PASSWORD=<mysql user password> EMAIL_TRANSPORT_DEFAULT_PASSWORD=<gmail app password>`
3. `fly volumes create passbolt_regens_unite --size 1`
4. `fly deploy`


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
- `fly doctor` to troubleshoot


### Use `scp`

see: https://fly.io/docs/reference/private-networking/#private-network-vpn

1. Install the Wireguard client: https://www.wireguard.com/install/
2. `fly wireguard create` to create a config file for Wireguard
  - Save this file with `.conf` extension and keep it. Do not commit it to the git repo!
3. Start the Wireguard tunnel
4. `fly ssh issue --agent`
5. `scp backup.sql root@mysql-regens-unite.internal:/tmp/backup.sql`
  - if you get an error à la "exec: "scp": executable file not found in $PATH" you need to install scp on the server first


## TODO
- figure out how to restore from backups
  - use mysql 5 (less memory intensive)
- document for community