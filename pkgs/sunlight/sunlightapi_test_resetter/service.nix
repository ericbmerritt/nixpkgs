{config, pkgs, lib, ...}:

with lib;

let
  cfg = config.services.sunlightapi_test_resetter;
  sysConfigFile = pkgs.writeText "sys.config" ''
    [{sunlightapi_test_resetter, [{postgresql_user, "${cfg.postgresqlUser}"},
                                  {postgresql_password, "${cfg.postgresqlPassword}"},
                                  {postgresql_port, ${toString cfg.postgresqlPort}},
                                  {sunlightapi_service_name, "${cfg.sunlightapiServiceName}"},
                                  {port, ${toString cfg.port}}]}].
  '';

in
  {
    options = {
      services.sunlightapi_test_resetter = {
        enable = mkOption {
           default = false;
           type = types.bool;
           description = ''
             Enable the lighttpd web server.
           '';
         };

         user = mkOption {
           default = "sunlightapi_test_resetter";
           type = with types; uniq string;
           description = ''
             Sunlightapi_Test_Resetter system user
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

         sunlightapiServiceName = mkOption {
           type = types.string;
           description = ''
             Provide the sunlight server name
          '';
         };

         port = mkOption {
           type = types.int;
           default = 4444;
           description = ''
             The port on which to run the system
          '';
         };
      };
    };
    config = mkIf cfg.enable {
      networking.firewall.allowedTCPPorts = [ cfg.port ];
      systemd.services.sunlightapi_test_resetter = {
        description = "Start the sunlightapi_test_resetter system under ${cfg.user}.";
        after = [ "network.target" "postgresql.service"];
        wantedBy = [ "multi-user.target" ];

        serviceConfig =  {
            User = "${cfg.user}";
            PermissionsStartOnly = true;

            KillSignal = "SIGINT";
            KillMode = "mixed";

            TimeoutSec = 120;
          };

        serviceConfig.ExecStart = ''
               ${pkgs.sunlight.sunlightapi_test_resetter}/var/sunlight/sunlightapi_test_resetter/bin/sunlightapi_test_resetter -config ${sysConfigFile}
        '';

      };
   };
 }