# Mac の CLI ツール一式。適用: brew bundle --file ~/dotfiles/Brewfile
# GUI アプリはここに書かず手で入れる

tap "hashicorp/tap"
tap "k1LoW/tap"

# 基本CLI
# git は CLT にもあるが、/usr/bin/git は DEVELOPER_DIR を見て起動するので、Nix の devShell 内（DEVELOPER_DIR が Nix の SDK）だと動かない
brew "git"
brew "gh"
brew "fd"
brew "ripgrep"
brew "tree"
brew "pandoc"
brew "neovim"
brew "lazygit"
brew "lazydocker"
brew "chezmoi"
brew "sheldon"
brew "k1LoW/tap/mo", trusted: true

# インフラ
brew "hashicorp/tap/terraform", trusted: true
brew "awscli"

# ランタイム（プロジェクトごとの言語は各リポジトリの flake.nix で持つ。Node は fnm で切り替える。Python のグローバルなツールは uv で入れる）
brew "deno"
brew "fnm"
brew "uv"
cask "temurin@25"

# Neovim のビルドに使う（treesitter のパーサ → tree-sitter-cli、Mason の gopls → go、nil_ls → rust）
brew "tree-sitter-cli"
brew "go"
brew "rust"
