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
        };
      };
      config = mkIf cfg.enable {
       networking.firewall.allowedTCPPorts = [ 3000 ];

        systemd.services.thorndyke = {
           description = "Start the thorndyke user under ${cfg.user}.";
           after = [ "network.target" ];
           wantedBy = [ "multi-user.target" ];

           serviceConfig.ExecStart = ''/var/setuid-wrappers/sudo -u ${cfg.user} -- ${pkgs.sunlight.thorndyke}/var/sunlight/thorndyke/bin/thorndyke -noshell'';
        };
     };
 }