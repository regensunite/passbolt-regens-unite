#!/usr/bin/env bash

set -eo pipefail

echo "extended entrypoint FTW :B"

data_dir="/data"
passbolt_config="/etc/passbolt"

# symlink /etc/passbolt/gpg to /data/gpg (on fly.io volume!)
[[ ! -e "$data_dir/gpg" ]] && mkdir "$data_dir/gpg"
rm -rf "$passbolt_config/gpg"
ln -s "$data_dir/gpg" "$passbolt_config/gpg"

# symlink /etc/passbolt/jwt to /data/jwt (on fly.io volume!)
[[ ! -e "$data_dir/jwt" ]] && mkdir "$data_dir/jwt"
rm -rf "$passbolt_config/jwt"
ln -s "$data_dir/jwt" "$passbolt_config/jwt"

# continue with this file: https://github.com/passbolt/passbolt_docker/blob/master/debian/bin/docker-entrypoint.sh.rootless
exec /docker-entrypoint.sh "$@"