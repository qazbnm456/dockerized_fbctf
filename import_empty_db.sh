#!/bin/bash

function log() {
  echo "[+] $1"
}

function import_empty_db() {
  local __user=$1
  local __pwd=$2
  local __u=$3
  local __p=$4
  local __db=$5
  local __path=$6
  local __mode=$7

  log "Creating DB - $__db"
  mysql -u "$__user" --password="$__pwd" -e "CREATE DATABASE \`$__db\`;"

  log "Importing schema..."
  mysql -u "$__user" --password="$__pwd" "$__db" -e "source $__path/database/schema.sql;"
  log "Importing countries..."
  mysql -u "$__user" --password="$__pwd" "$__db" -e "source $__path/database/countries.sql;"
  log "Importing logos..."
  mysql -u "$__user" --password="$__pwd" "$__db" -e "source $__path/database/logos.sql;"

  log "Creating user..."
  mysql -u "$__user" --password="$__pwd" -e "CREATE USER '$__u'@'%' IDENTIFIED BY '$__p';"
  mysql -u "$__user" --password="$__pwd" -e "GRANT ALL PRIVILEGES ON \`$__db\`.* TO '$__u'@'%';"
  mysql -u "$__user" --password="$__pwd" -e "FLUSH PRIVILEGES;"

  log "DB Connection file"
  cat "$__path/extra/settings.ini.example" | sed "s/DATABASE/$__db/g" | sed "s/MYUSER/$__u/g" | sed "s/MYPWD/$__p/g" > "$__path/settings.ini"

  local PASSWORD
  log "Adding default admin user"
  PASSWORD=$(head -c 500 /dev/urandom | md5sum | cut -d" " -f1)

  log "The password for admin is: $PASSWORD"
  HASH=$(hhvm -f "$__path/extra/hash.php" "$PASSWORD")
  mysql -u "$__user" --password="$__pwd" "$__db" -e "INSERT INTO teams (name, password_hash, admin, protected, logo, created_ts) VALUES('admin', '$HASH', 1, 1, 'admin', NOW());"
}
