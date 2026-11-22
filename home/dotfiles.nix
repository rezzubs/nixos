# Link files to the repository checkout instead of the nix store, so edits apply
# without a rebuild.
{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.custom.dotfiles;
in
{
  options.custom.dotfiles = {
    path = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nixos";
      description = "Where this repository is checked out.";
    };

    link = lib.mkOption {
      type = lib.types.functionTo lib.types.path;
      readOnly = true;
      description = ''
        Turns a path literal inside this repository into a link to the same file
        in the checkout. Use the result as a home file `source`.
      '';
      default =
        file:
        let
          # Path literals evaluate to the flake's copy in the store, so the
          # store prefix is swapped for the checkout location.
          repoRoot = "${toString inputs.self}/";
          filePath = toString file;
        in
        assert lib.assertMsg (lib.hasPrefix repoRoot filePath) "${filePath} is not inside the repository";
        # Catches typos at evaluation time instead of creating a dangling link.
        assert lib.assertMsg (builtins.pathExists file) "${filePath} does not exist";
        config.lib.file.mkOutOfStoreSymlink "${cfg.path}/${lib.removePrefix repoRoot filePath}";
    };
  };
}
