# Homelab

This repo contains the details to provision a simple homelab using nixos and
docker! For this setup the following services are used:

- Ngninx Proxy Manager - Used as a reverse proxy for all the services with an
  HTTP interface.
- Netbird - Used for remote access into the homelab network.
- Pi-Hole - Used for Ad-Blocking and a local DNS.
- Syncthing - Used to sync files across devices and backup files.
- VaultWarden - Used to maintain a backup copy of a bitwarden vault.
- Uptime Kuma - Used to monitor services and their uptime.

This repo is still under construction, but will mainly be used to setup a home
server to backup and sync files across devices via syncthing and to keep a local
copy of a bitwarden vault.

## To-Do's

Below are a list of items that still need work or have been completed.

- [ ] Use nix to configure the server with the following:
    - [x] Install Podman
    - [x] Static IP
    - [ ] Firewall Rules
    - [ ] Setup a cron job that will automatically pull down changes and 
      apply them to the system from gitlab.
- [ ] Build a compose file to configure the services I use:
    - [x] Ngninx Proxy Manager
    - [x] Netbird
    - [x] Pi-Hole
    - [x] Syncthing
    - [ ] VaultWarden
    - [ ] Uptime Kuma.
- [ ] Update readme with provisioning instructions.
