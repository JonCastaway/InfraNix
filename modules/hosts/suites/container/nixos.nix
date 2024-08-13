{
  options,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.yomaq.suites.container;
in
{
  options.yomaq.suites.container = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = '''';
    };
  };

  config = lib.mkIf cfg.enable {
    yomaq = {
      zsh.enable = true;
      agenix.enable = true;
      nixSettings.enable = true;
      tailscale.enable = true;
    };
    networking.useHostResolvConf = lib.mkForce false;
    networking.useDHCP = lib.mkForce true;

  };
}
