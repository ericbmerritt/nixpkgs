{config, pkgs, lib, ...}:

with lib;

let
  cfg = config.services.sunlightapi;
  sysConfigFile = pkgs.writeText "sys.config" ''
    [{rest_server, [{postgresql_user, "${cfg.postgresqlUser}"},
                    {postgresql_password, "${cfg.postgresqlPassword}"},
                    {postgresql_port, ${toString cfg.postgresqlPort}}]},
     {episcina, [{max_restarts, 2000},
                 {max_seconds_between_restarts, 7200}]}].
  '';

in
  {
    options = {
      services.sunlightapi = {
        enable = mkOption {
           default = false;
           type = types.bool;
           description = ''
             Enable the lighttpd web server.
           '';
         };

         user = mkOption {
           default = "sunlightapi";
           type = with types; uniq string;
           description = ''
             Sunlightapi system user
           '';
         };

         postgresqlUser = mkOption {
           type = with types; uniq string;
           description = ''
             The password for the postgresql user
           '';
         };

         postgresqlPassword = mkOption {
           type = with types; uniq string;
           description = ''
             The password for the postgresql user
           '';
         };

         postgresqlPort = mkOption {
           type = types.int;
           description = ''
             The port on which PostgreSQL listens.
          '';
         };
      };
    };
    config = mkIf cfg.enable {
      networking.firewall.allowedTCPPorts = [ 4000 ];
      systemd.services.sunlightapi = {
        description = "Start the sunlightapi user under ${cfg.user}.";
        after = [ "network.target" "postgresql.service"];
        wantedBy = [ "multi-user.target" ];

        serviceConfig =  {
            User = "${cfg.user}";
            PermissionsStartOnly = true;

            KillSignal = "SIGINT";
            KillMode = "mixed";

            TimeoutSec = 120;
          };

        environment = { postgresql_user = "${cfg.postgresqlUser}";
                        postgresql_password = "${cfg.postgresqlPassword}";
                        postgresql_port = "${toString cfg.postgresqlPort}"; };

        serviceConfig.ExecStart = ''
               ${pkgs.sunlight.sunlightapi}/var/sunlight/sunlightapi/bin/sunlightapi -config ${sysConfigFile}
        '';

      };
   };
 }