{ pkgs }:

{
  "extensions.experimental.affinity" = {
    "asvetliakov.vscode-neovim" = 1;
  };

  "telemetry.telemetryLevel" = "off";

  "terminal.integrated.profiles.linux" = {
    "bash" = {
      "path" = "${pkgs.bashInteractive}/bin/bash";
      "icon" = "terminal-bash";
    };
  };

  "vscode-neovim.neovimClean" = true;
}
