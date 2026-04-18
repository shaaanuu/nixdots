{ config, lib, pkgs, ... }:

{
  networking.firewall.checkReversePath = "loose";

  networking.wg-quick.interfaces.proton = {
    autostart = false;
    address = [ "10.2.0.2/32" "2a07:b944::2:2/128" ];
    dns = [
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
      "10.2.0.1"
      "2a07:b944::2:1"
    ];

    # gotta create this file, and paste the private key
    privateKeyFile = "/etc/wireguard/proton.key";

    peers = [{
      publicKey = "RGkflpj8nU73t7WgEmZQ45f+wF1QM3fDiKjimp5iCGA=";
      allowedIPs = [ "0.0.0.0/0" "::/0" ];
      # endpoint = "185.177.124.84:51820";  -- IPV4
      endpoint = "[2a00:7c80:0:3a4::10]:51820"; # -- IPV6
      persistentKeepalive = 25;
    }];
  };

  # switch for wake / kill
  programs.zsh.shellAliases = {
    vpn = "sudo systemctl start wg-quick-proton";
    vpn-off = "sudo systemctl stop wg-quick-proton";
  };
}
