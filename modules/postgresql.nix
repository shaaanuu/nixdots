{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      host  all all 127.0.0.1/32 trust
      host  all all ::1/128 trust
    '';
  };

  # pgAdmin4
  services.pgadmin = {
    enable = true;
    openFirewall = true;

    # nobody's gonna know...
    initialEmail = "admin@local.com";
    initialPasswordFile = "/etc/pgadmin-pass";
  };
  environment.etc."pgadmin-pass".text = "123456";

  # register the default server
  environment.etc."pgadmin/servers.json".text = ''
    {
      "Servers": {
        "1": {
          "Name": "Local Postgres",
          "Group": "Servers",
          "Host": "127.0.0.1",
          "Port": 5432,
          "MaintenanceDB": "mydatabase",
          "Username": "postgres",
          "SSLMode": "prefer"
        }
      }
    }
  '';

  systemd.services.pgadmin-seed = {
    wantedBy = pkgs.lib.mkForce [ ];
    after = [ "pgadmin.service" ];
    requires = [ "pgadmin.service" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.pgadmin4}/bin/pgadmin4-cli load-servers /etc/pgadmin/servers.json \
          --replace \
          --user admin@local.com \
          --sqlite-path /var/lib/pgadmin/pgadmin4.db
      '';
    };
  };

  # postman
  environment.systemPackages = with pkgs; [
    postman
  ];

  # switch for wake / kill
  programs.zsh.shellAliases = {
    pgadmin = "sudo systemctl start pgadmin.service";
    pgadmin-off = "sudo systemctl stop pgadmin.service";
  };

  # prevents autostart
  systemd.services.pgadmin.wantedBy = pkgs.lib.mkForce [ ];
}
