# Mac の CLI ツール一式。適用: brew bundle --file ~/dotfiles/Brewfile
# GUI アプリはここに書かず手で入れる

tap "hashicorp/tap"
tap "k1LoW/tap"

# 基本CLI
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
brew "k1LoW/tap/mo"

# インフラ
brew "hashicorp/tap/terraform"
brew "awscli"

# ランタイム（プロジェクトごとの言語は各リポジトリの flake.nix で持つ。Node は fnm で切り替える。Python のグローバルなツールは uv で入れる）
brew "deno"
brew "fnm"
brew "uv"
cask "temurin@25"
