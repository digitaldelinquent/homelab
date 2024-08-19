# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
        ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "homelab"; # Define your hostname.

    # Enable networking
    networking.networkmanager.enable = true;

    # Set static IPv4 address, default gateway and default DNS
    networking.interfaces.enp88s0.ipv4.addresses = [ {
        address = "192.168.1.241";
        prefixLength = 24;
    } ];

    networking.defaultGateway = "192.168.1.1";
    networking.nameservers = ["1.1.1.1"];

    # Firewall configuration
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 
            22 # SSH
            80 # HTTP
            443 # HTTPS
            53 # DNS
            22000 # Syncthing
        ];
        allowedUDPPorts = [
            53 # DNS
            22000 # Syncthing
            21027 # Syncthing
        ];
    };

    # Set your time zone.
    time.timeZone = "America/Los_Angeles";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # Configure keymap in X11
    services.xserver = {
        layout = "us";
        xkbVariant = "";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.admin = {
        isNormalUser = true;
        description = "admin";
        extraGroups = [ "networkmanager" "wheel" "docker" ];
        packages = with pkgs; [];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
        neovim
        wget
        git
        docker
        docker-compose
    ];

    # List services that you want to enable:
    services.openssh = {
        # Enable SSH
        enable = true;

        # Require public key authentication for better security
        settings.PasswordAuthentication = false;
        settings.KbdInteractiveAuthentication = false;
        settings.PermitRootLogin = "no";
    };

    # Docker config
    virtualisation.docker.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken.
    system.stateVersion = "23.11";
}
