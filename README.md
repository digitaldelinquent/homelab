# Homelab

This repo contains the details to provision a simple homelab using nixos and
docker! For this setup the following services are used:

- Caddy: Used as a reverse proxy for all the services with an
  HTTP interface.
- Netbird: Used for remote access into the homelab network.
- Pi-Hole: Used for Ad-Blocking and a local DNS.
- Syncthing: Used to sync files across devices and backup files.
- VaultWarden: Used to maintain a backup copy of a bitwarden vault.

This repo is still under construction, but will mainly be used to setup a home
server to backup and sync files across devices via syncthing and to keep a local
copy of a bitwarden vault.

## Provisioning

In order to provision your server with the same config simply clone this repo
and run the following command:

`sudo nixos-rebuild switch --flake . --impure`

After that you will need to spin up the docker services using docker compose:

```
docker network create proxy
NB_SETUP_KEY=<NETBIRD_KEY> docker compose up -d
```

or if netbird container has already been added to the netbird network:

```
docker network create proxy
docker compose up -d
```
