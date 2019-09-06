#!/usr/bin/env sh

set -e

if [ ! -f /etc/gobackup/config-raw.yaml ]; then
 echo "Backup definitions file '/etc/gobackup/config-raw.yaml' missing, exiting."
 exit 1
fi

interpolator /etc/gobackup/config-raw.yaml /etc/gobackup/gobackup.yaml

if [ "${#}" -eq 2 ] && [ "${1}" = 'cron' ]; then
  echo "Starting periodic backups with cron expression [${2}]"
  # Crontabs in /etc/cron.d use a different syntax than user crontabs, see https://stackoverflow.com/a/42719311
  cat <<EOF >> /var/spool/cron/root
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin
MAILTO=
${2} gobackup perform
EOF

  crontab /var/spool/cron/root
  /usr/sbin/crond -n -x sch
else
  echo "Executing 'gobackup perform' once"
  gobackup "$@"
fi
