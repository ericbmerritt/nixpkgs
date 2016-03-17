{config, pkgs, lib, ...}:
with lib;
let
  cfg = config.services.priestley;
in {
  options = {
    services.priestley = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable <command>priestley</command>";
      };

      projects = mkOption {
        type = types.str;
        description = ''
          A comma seperated list of the projects to watch
        '';
      };

      github-oauth-token = mkOption {
        type = types.str;
        description = ''
          The auth token priestley uses to connect to github
        '';
      };

      github-user = mkOption {
        type = types.str;
        description = ''
          The user to which the github-oauth-token belongs
        '';
      };

      pollIntervalSecs = mkOption {
        default = "600";
        type = types.str;
        description = ''
          The poll interval for checking for changes
        '';
      };

      working-dir = mkOption {
        default = "/var/priestley";
        type = types.str;
        description = ''
          The working directory of the priestley system
        '';
      };
      user = mkOption {
        type = with types; uniq string;
        description = ''
          Priestley system user
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    systemd.services.priestley = {
      description = "Start the priestley as ${cfg.user}.";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      preStart = ''
        /var/setuid-wrappers/sudo -u "${cfg.user}" -- \
            ${pkgs.coreutils}/bin/mkdir -m 0700 -p "/home/${cfg.user}/.nixpkgs"
        /var/setuid-wrappers/sudo -u "${cfg.user}" -- \
            echo "{ allowUnfree = true; }" > "/home/${cfg.user}/.nixpkgs/config.nix";

        ${pkgs.coreutils}/bin/mkdir -m 0700 -p "${cfg.working-dir}"
        ${pkgs.coreutils}/bin/chown -R "${cfg.user}":users "${cfg.working-dir}"
      '';

      serviceConfig.ExecStart = ''
        /var/setuid-wrappers/sudo -u "${cfg.user}" -- \
            ${pkgs.sunlight.priestley}/bin/priestley monitor \
            --repos "${cfg.projects}" --working-dir "${cfg.working-dir}" \
            --github-user "${cfg.github-user}" \
            --github-oauth-token "${cfg.github-oauth-token}" \
            --poll-interval-secs "${cfg.pollIntervalSecs}"
      '';
    };
  };
}