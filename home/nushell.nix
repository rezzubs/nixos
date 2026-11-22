# A modern shell.
{ config, ... }:
{
  imports = [ ./dotfiles.nix ];

  programs.nushell.enable = true;

  # Home-manager generates config.nu with the shell integrations, so personal
  # settings go in an autoload file, which nushell sources after it.
  xdg.configFile."nushell/autoload/config.nu".source =
    config.custom.dotfiles.link ./nushell/config.nu;
}
