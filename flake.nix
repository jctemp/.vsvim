{
  description = "VSCode/ Neovim Hybrid";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = { nixpkgs, nixpkgs-unstable, pre-commit-hooks, ... }:
    let
      checks = {
        pre-commit-hooks = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            deadnix.enable = true;
            statix.enable = true;

            stylua.enable = true;
          };
        };
      };
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };

      vscode.userSettings = import ./settings/vscode-settings.nix { inherit pkgs; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ ];
        inherit (checks.pre-commit-hooks) shellHook;
      };
      nixosModules.homeMangerModule = {
        home.packages = with pkgs; [
          ripgrep
          fd

          clang-tools
          lua-language-server
          marksman
          metals
          nil
          nodePackages.bash-language-server
          nodePackages.grammarly-languageserver
          nodePackages.typescript-language-server
          nodePackages.vscode-langservers-extracted
          python311Packages.python-lsp-server
          rust-analyzer
          texlab
          typst-lsp
        ];

        programs.vscode = {
          enable = true;
          enableExtensionUpdateCheck = true;
          enableUpdateCheck = true;
          package = pkgs-unstable.vscode;
          extensions = with pkgs-unstable.vscode-extensions; [
            # Utils
            asvetliakov.vscode-neovim
            vspacecode.whichkey
            christian-kohler.path-intellisense
            pkief.material-icon-theme
            ms-vscode-remote.remote-ssh

            # Language support
            jnoortheen.nix-ide
            nvarner.typst-lsp
            redhat.vscode-yaml
            tamasfe.even-better-toml
            yzhang.markdown-all-in-one

            # Java
            redhat.java
            redhat.vscode-xml
            redhat.vscode-yaml
            vscjava.vscode-java-debug
            vscjava.vscode-java-test
            vscjava.vscode-maven
          ];
          mutableExtensionsDir = true;
          inherit (vscode) userSettings;
        };
        home.file.".config/nvim" = {
          enable = true;
          recursive = true;
          source = ./settings/neovim;
        };
        programs.neovim = {
          enable = true;
          withNodeJs = false;
          withPython3 = false;
          withRuby = false;
          defaultEditor = true;
          plugins = with pkgs.vimPlugins; [
            lualine-nvim
            nvim-autopairs
            nvim-treesitter.withAllGrammars
            plenary-nvim
            popup-nvim
            rose-pine
            telescope-nvim
            vim-sleuth

            cmp-buffer
            cmp-nvim-lsp
            cmp-path
            cmp_luasnip
            friendly-snippets
            luasnip
            nvim-cmp
            nvim-lspconfig
          ];
        };
      };
    };
}
