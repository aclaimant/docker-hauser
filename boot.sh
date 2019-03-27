#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

echo "$DIR"

if [[ "$HAUSER_Warehouse" == "redshift" ]]; then
  export HAUSER_UseRedshift=1
elif [[ "$HAUSER_Warehouse" == "bigquery" ]]; then
  export HAUSER_UseBigQuery=1
elif [[ "$HAUSER_Warehouse" == "local" ]]; then
  export HAUSER_UseLocal=1
else
  echo "Unknown Hauser warehouse"
  exit 1
fi

jq -n env | mustache /server-conf/config.toml.mustache > /server-conf/config.toml

cat /server-conf/config.toml

hauser -c /server-conf/config.toml
