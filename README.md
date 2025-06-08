# Homelab

The following section details how to provision a simple homelab using nixos 
and docker! For this setup the following services are used:

- Watchtower: Watches for updates of the images used by the below services.
- Caddy: Used as a reverse proxy for all the services with an
  HTTP interface.
- Netbird: Used for remote access into the homelab network.
- CloudFlare Tunnels: To make certain sites accessible to the internet.
- Pi-Hole: Used for Ad-Blocking and a local DNS.
- Syncthing: Used to sync files across devices and backup files.
- VaultWarden: Used to maintain a backup copy of a bitwarden vault.
- Uptime Kuma: Application Uptime Monitoring

In order to provision your server with the same config simply clone this repo
and run the following command:

`sudo nixos-rebuild switch --flake .`

> **NOTE** This uses the UUIDs of my disks, please copy your hardware config
> after you installed nixos into this repo and delete the existing
> `hardware-configuration.nix`. After that the git tree will be dirty, but you
> should be able to build the system without your install being borked. You
> could also just copy your drive UUIDs into the hardware-configuration.nix file 
> and that should work too.

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
