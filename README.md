# VSVim

VSVim is a flake configuration for home-manager that provides VSCode with Neovim as a backend.
This means that you can use VSCode with Vim-motions, which gives you the best of both worlds.
VSCode is a popular code editor with many features, such as syntax highlighting, code completion, and debugging.
Neovim is a modal text editor that is known for its speed and efficiency.

The project also has Neovim pre-configured. 
This means that you can get started with VSVim quickly and easily, without having to spend time configuring Neovim yourself.
However, you are welcome to modify it to your preferences.

```
├── README.md
├── flake.lock
├── flake.nix
└── settings
    ├── neovim
    │   ├── init.lua
    │   └── lua
    │       ├── config-autocmp.lua
    │       ├── config-autopair.lua
    │       ├── config-lsp.lua
    │       ├── config-lualine.lua
    │       ├── config-telescope.lua
    │       ├── config-treesitter.lua
    │       ├── options.lua
    │       └── remap.lua
    └── vscode-settings.nix
```