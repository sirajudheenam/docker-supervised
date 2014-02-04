#!/bin/bash

set -e
set -u

## required settings
##   logstash server:port
##   ssl ca, cert, key: /etc/logstash/pki/lumberjack.{crt,crt,key}
##   tags: comma-delimited
##   log files to send: /etc/logstash-forwarder.d

/usr/local/bin/gen_logstash_forwarder_config.py \
    "${LOGSTASH_FORWARDER_DEST}" \
    "${LOGSTASH_FORWARDER_TAGS}"

exec /opt/logstash-forwarder/bin/logstash-forwarder \
    -config /etc/logstash-forwarder.json \
    -from-beginning=true \
    -spool-size 100
