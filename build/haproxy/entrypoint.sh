#!/bin/bash

set -o errexit
set -o nounset

readonly RSYSLOG_PID="/var/run/rsyslogd.pid"

main() {

  for domain in $DOMAINS; do
    if [ ! -f /var/lib/certs/haproxy/${domain}.pem ]; then
      echo "Creating Self Signed Certificate for ${domain}"
      mkdir -p /var/lib/certs/haproxy/
      cd /tmp
      openssl req -x509 -nodes -subj "/CN=${domain}" -newkey rsa:4096 -keyout ${domain}-key.pem -out ${domain}-cert.pem -days 365
      cat "${domain}-cert.pem" "${domain}-key.pem" > /var/lib/certs/haproxy/${domain}.pem
      rm "${domain}-cert.pem" "${domain}-key.pem"
    fi
  done

  start_rsyslogd
  start_haproxy
}

# make sure we have rsyslogd's pid file not
# created before
start_rsyslogd() {
  rm -f $RSYSLOG_PID
  rsyslogd
}

# Starts the load-balancer (haproxy) with
# whatever arguments we pass to it ("$@")
start_haproxy() {
  # haproxy "$@"
  haproxy -W -db -f /etc/haproxy/
}

main
