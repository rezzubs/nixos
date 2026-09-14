# Defaults for machines with a graphical environment
{lib, ...}: {
  imports = [./universal.nix];

  custom = lib.mkDefault {
    ghostty.enable = true;
    obsidian.enable = true;
  };
}
