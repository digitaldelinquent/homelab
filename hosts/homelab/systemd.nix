{ config, pkgs, ... }:
let
    homedir="/home/admin/homelab";
in {
    systemd.timers."deploy" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "2m";
          OnUnitActiveSec = "2m";
          Unit = "deploy.service";
        };
    };

    systemd.services."deploy" = {
        script = ''
            # Fetch changes
            git -C ${homedir} fetch

            # Get hash for HEAD and remote
            LOCAL=$(git -C ${homedir} rev-parse HEAD)
            REMOTE=$(git -C ${homedir} rev-parse origin/main)

            echo "| $(date) | Local: $LOCAL"
            echo "| $(date) | Remote: $REMOTE"

            # Check for changes in remote and local. If there are any pull the changes and
            # apply them.
            if [ $LOCAL!=$REMOTE ];
            then
                echo "| $(date) | Difference detected, pulling latest changes..."
                git pull &&
                nixos-rebuild switch --flake . --impure &&
                git -C ${homedir} add . &&
                git -C ${homedir} commit -m "updating flake.lock file" &&
                git -C ${homedir} push &&
                docker compose -f ${homedir} up -d
            else
                echo "| $(date) | No changes to be made"
            fi
        '';

        serviceConfig = {
            Type = "oneshot";
            User = "root";
        };
    };
}
