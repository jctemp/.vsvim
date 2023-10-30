{
  description = "VSCode/ Neovim Hybrid";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = { nixpkgs, pre-commit-hooks, ... }:
    let
      checks = {
        pre-commit-hooks = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            deadnix.enable = true;
            statix.enable = true;
          };
        };
      };
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ ];
        inherit (checks.pre-commit-hooks) shellHook;
      };
    };
}
