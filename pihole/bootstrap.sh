#!/usr/bin/env bash

# Notes:
# sudo journalctl -fu google-startup-scripts.service

# Install PiHole
mkdir -p /etc/pihole
cat >/etc/pihole/setupVars.conf <<END
PIHOLE_INTERFACE=${NET_INTERFACE}
PIHOLE_DNS_1=8.8.8.8
PIHOLE_DNS_2=8.8.4.4
QUERY_LOGGING=false
INSTALL_WEB_SERVER=true
INSTALL_WEB_INTERFACE=true
LIGHTTPD_ENABLED=true
CACHE_SIZE=10000
DNS_FQDN_REQUIRED=true
DNS_BOGUS_PRIV=true
DNSMASQ_LISTENING=local
WEBPASSWORD=
BLOCKING_ENABLED=true
END
curl -sSL https://install.pi-hole.net | sudo bash -s -- --unattended

# Install WireGuard with PiHole
cat >/dev/shm/wireguard-setupVars.conf <<END
pivpnforceipv6route=1
IPv4dev=${NET_INTERFACE}
install_user=${VM_USER}
VPN=wireguard
pivpnPORT=${WG_PORT}
pivpnDNS1=10.77.77.1
pivpnPROTO=udp
pivpnDEV=wg0
pivpnNET=10.77.77.0
subnetClass=24
pivpnenableipv6=0
ALLOWED_IPS="10.77.77.0/24"
UNATTUPG=1
END
curl -sSL https://install.pivpn.io | sudo bash -s -- --unattended /dev/shm/wireguard-setupVars.conf

# Install OPS agent
# curl -sSL https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh | sudo bash -s -- --also-install
