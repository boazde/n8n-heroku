#!/bin/sh

# check if port variable is set or go with default
if [ -z ${PORT+x} ]; then echo "PORT variable not defined, leaving N8N to default port."; else export N8N_PORT="$PORT"; echo "N8N will start on '$PORT'"; fi

# regex function
parse_url() {
  eval $(echo "$1" | sed -e "s#^\(\(.*\)://\)\?\(\([^:@]*\)\(:\(.*\)\)\?@\)\?\([^/?]*\)\(/\(.*\)\)\?#${PREFIX:-URL_}SCHEME='\2' ${PREFIX:-URL_}USER='\4' ${PREFIX:-URL_}PASSWORD='\6' ${PREFIX:-URL_}HOSTPORT='\7' ${PREFIX:-URL_}DATABASE='\9'#")
}

# Use Neon database connection
echo "Using Neon database connection"
# prefix variables to avoid conflicts and run parse url function on arg url
PREFIX="N8N_DB_" parse_url "$NEON_DATABASE_URL"

# For Neon, we need to ensure SSL mode is properly set
export DB_POSTGRESDB_SSL_CA="/etc/ssl/certs/ca-certificates.crt"

echo "Database connection: $N8N_DB_SCHEME://$N8N_DB_USER:***@$N8N_DB_HOSTPORT/$N8N_DB_DATABASE"

# Separate host and port    
N8N_DB_HOST="$(echo $N8N_DB_HOSTPORT | sed -e 's,:.*,,g')"
N8N_DB_PORT="$(echo $N8N_DB_HOSTPORT | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g')"

# Use default PostgreSQL port if none specified
if [ -z "$N8N_DB_PORT" ]; then
  N8N_DB_PORT=5432
fi

export DB_TYPE=postgresdb
export DB_POSTGRESDB_HOST=$N8N_DB_HOST
export DB_POSTGRESDB_PORT=$N8N_DB_PORT
export DB_POSTGRESDB_DATABASE=$N8N_DB_DATABASE
export DB_POSTGRESDB_USER=$N8N_DB_USER
export DB_POSTGRESDB_PASSWORD=$N8N_DB_PASSWORD

# For Neon, ensure SSL is properly configured
if [ -n "$NEON_DATABASE_URL" ]; then
  export DB_POSTGRESDB_SSL_ENABLED=true
  # Neon requires SSL, but we want to make the rejection of unauthorized certs configurable
  if [ -z "$DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED" ]; then
    export DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false
  fi
fi

# kickstart nodemation
n8n