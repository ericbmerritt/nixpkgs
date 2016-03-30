{config, pkgs, lib, ...}:

with lib;

let
  cfg = config.services.thorndyke;
in
  {
    options = {
      services.thorndyke = {
        enable = mkOption {
           default = false;
           type = types.bool;
           description = ''
             Enable the lighttpd web server.
           '';
         };

         user = mkOption {
           default = "thorndyke";
           type = with types; uniq string;
           description = ''
             Thorndyke system user
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
      systemd.services.thorndyke = {
        description = "Start the thorndyke user under ${cfg.user}.";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig.ExecStart = ''
            /var/setuid-wrappers/sudo -u ${cfg.user} -- \
                ${pkgs.sunlight.thorndyke}/var/sunlight/thorndyke/bin/thorndyke -noshell -- \
                   postgresql-user=${cfg.postgresqlUser} \
                   postgresql-password=${cfg.postgresqlPassword} \
                   postgresql-port=${toString cfg.postgresqlPort}'';
      };
   };
 }