# Install
## Font
Need to install and activate Nerd Font.

- https://www.nerdfonts.com/

## For telescope
Need to install following tools.

1. fd
    - https://github.com/sharkdp/fd
2. rg
    - https://github.com/BurntSushi/ripgrep

## LSP
Type `:Mason` to install lsp.

- For frequently used languages
    - Apex
        - apex-language-server
    - LWC
        * lwc-language-server
    - Typescript, Javascript
        * typescript-language-server
    - HTML
        * html-lsp
    - CSS
        * css-lsp
    - Java
        * java-language-server
    - Python
        * java-lsp-server
    - Lua
        * lua-language-server
    - Markdown
        * marksman

# Avante(github copilot)
Enable to chat with github copilot (or other AI) on Neovim.

## StartUp
To start using github copilot via avante.nvim,
1. Open Neovim
2. Type `:Copilot auth`.
3. Then open dialog to notice one time password and URL for login to github.
4. Login to my account and type one time password.

## Usage
### Commands
Commands list frequently use.
If want to know about other commands, see help by type `:h avante` and then search "Usage" section.
|command|Description|Additional Info|
| - | - | - |
| <leader>aa | show sidebar | Use when start chat. |
| <leader>at | toggle sidebar visibility | Use when hide sidebar, or show sidebar. |
| <leader>ar | refresh sidebar | |
| <leader>af | switch sidebar focus | Use when focus code editor while display sidebar. |


