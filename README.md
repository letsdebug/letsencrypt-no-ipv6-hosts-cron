# letsencrypt-no-ipv6-hosts-cron

This shell script forces `acme-v02.api.letsencrypt.org` to resolve via IPv4 on servers with
IPv6 interfaces that are enabled but dysfunctional in any number of ways.

It works by updating an entry in the server's `/etc/hosts` file on a schedule, to the latest
IPv4 address found for that domain. This is necessary because the IP address rotates regularly.

## Installation

```bash

# Download script
wget -O /usr/local/sbin/letsencrypt-no-ipv6-hosts-cron.sh "https://raw.githubusercontent.com/letsdebug/letsencrypt-no-ipv6-hosts-cron/master/letsencrypt-no-ipv6-hosts-cron.sh"
chmod 0700 /usr/local/sbin/letsencrypt-no-ipv6-hosts-cron.sh

# Install cron task
echo '0 * * * * root /usr/local/sbin/letsencrypt-no-ipv6-hosts-cron.sh' > /etc/cron.d/letsencrypt-no-ipv6-hosts-cron
chmod 0600 /etc/cron.d/letsencrypt-no-ipv6-hosts-cron
```