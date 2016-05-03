{config, pkgs, lib, ...}:
with lib;
let
  cfg = config.services.infpipe;
in {
  options = {
    services.infpipe = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable <command>infpipe</command>";
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
          The auth token infpipe uses to connect to github
        '';
      };

      github-user = mkOption {
        type = types.str;
        description = ''
          The user to which the github-oauth-token belongs
        '';
      };

      pollIntervalSecs = mkOption {
        default = 60;
        type = types.int;
        description = ''
          The poll interval for checking for changes
        '';
      };

      working-dir = mkOption {
        default = "/var/infpipe";
        type = types.str;
        description = ''
          The working directory of the infpipe system
        '';
      };
      user = mkOption {
        type = with types; uniq string;
        description = ''
          Infpipe system user
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    systemd.services.infpipe = {
      description = "Start the infpipe as ${cfg.user}.";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig.Restart = "always";
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
            ${pkgs.sunlight.infpipe}/bin/infpipe monitor \
            --repos "${cfg.projects}" --working-dir "${cfg.working-dir}" \
            --github-user "${cfg.github-user}" \
            --github-oauth-token "${cfg.github-oauth-token}" \
            --poll-interval-secs "${toString cfg.pollIntervalSecs}"
      '';
    };
  };
}