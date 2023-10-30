require "options"
require "remap"

if not vim.g.vscode then
    vim.cmd.colorscheme("rose-pine")

    require "config-autopair"
    require "config-lualine"
    require "config-telescope"
    require "config-treesitter"
    require "config-autocmp"
    require "config-lsp"
end

