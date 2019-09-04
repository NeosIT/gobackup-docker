#!/usr/bin/env sh

set -e

if [ ! -f /etc/gobackup/config-raw.yaml ]; then
 echo "Backup definitions file '/etc/gobackup/config-raw.yaml' missing, exiting."
 exit 1
fi

interpolator /etc/gobackup/config-raw.yaml /etc/gobackup/gobackup.yaml

if [ "${#}" -eq 2 ] && [ "${1}" = 'cron' ]; then
  echo "Starting periodic backups with cron expression [${2}]"
  echo "${2} gobackup perform" > /etc/periodic/gobackup \
  && crontab /etc/periodic/gobackup \
  && /usr/sbin/crond -f -l 0
else
  echo "Executing 'gobackup perform' once"
  gobackup "$@"
fi
