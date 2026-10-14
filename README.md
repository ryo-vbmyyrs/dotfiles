# dotfiles

共通の設定ファイルをまとめて管理する。
[chezmoi](https://www.chezmoi.io/) で管理している。
各ツールはPCごとにインストールする。MacのCLIツールなら`Brewfile`でまとめてインストールできる。

## 構成

```
~/dotfiles/
  .chezmoiroot          # chezmoi の対象ディレクトリ名（chezmoi）を書いたファイル
  README.md
  Brewfile              # Mac の CLI ツールの一覧。brew bundle で入れる
  Brewfile.local        # そのマシンだけで Homebrew で入れるもの。Git 管理しない（無くてもよい）
  chezmoi/              # ホームに置く設定ファイル。dot_zshrc.tmpl → ~/.zshrc
```

- GUI アプリは Mac・Windows とも手で入れる。`Brewfile` にも書かない
- どうしても Homebrew で入れたい GUI アプリ（cask）は `Brewfile.local` に書く。`Brewfile` の末尾で読み込んでいる
- `.zshrc` と `.zshenv` は Mac と WSL で同じファイルを使う。片方でだけ必要な行は `{{ if eq .chezmoi.os "darwin" }}`（WSL は `"linux"`）で囲み、その OS でだけ出力する
- プロジェクトごとのツール（zig、そのプロジェクトの node、python）は各リポジトリの `flake.nix` と `.envrc` で持つ

## Mac のセットアップ

1. Xcode Command Line Tools を入れる。これでGitとかも入るし、たぶん気付いたら入れることになってる。
   ```sh
   xcode-select --install
   ```
2. Homebrew を入れる。多分調べたらわかる。
3. このリポジトリを clone する。git は手順1で入っている。
   どこでもいいけど`~/dotfiles`が楽でしょう。
4. CLI ツールを入れる
   ```sh
   brew bundle --file ~/dotfiles/Brewfile
   ```
5. Neovim を入れる。バージョンが変わると設定の動きが変わるので、Homebrew ではなく公式のビルド済みファイルで **v0.12.6** を入れる（[Neovim のバージョン](#neovim-のバージョン)を参照）
   ```sh
   curl -LO https://github.com/neovim/neovim/releases/download/v0.12.6/nvim-macos-arm64.tar.gz
   xattr -c nvim-macos-arm64.tar.gz   # 入れないと macOS に実行を止められる
   mkdir -p ~/.local/opt ~/.local/bin
   tar xzf nvim-macos-arm64.tar.gz -C ~/.local/opt
   ln -sf ~/.local/opt/nvim-macos-arm64/bin/nvim ~/.local/bin/nvim
   rm nvim-macos-arm64.tar.gz
   ```
6. chezmoi で設定ファイルを配置する。`--source` を付けないと `~/.local/share/chezmoi` に別途 clone されるので必ず付ける
   ```sh
   chezmoi init --source ~/dotfiles --apply
   ```
7. どうせNixを使うことになるのでインストールしておく。調べたらわかるだろうけど https://zero-to-nix.com/start/install/#run の通りに進めればいいんじゃないかな。

## Windows（WSL2）のセットアップ

1. WSL2 と Ubuntu を入れる。PowerShell で `wsl --install`
2. WSL の中でこのリポジトリを clone し、chezmoi を入れて設定ファイルを置く。手順は Mac の手順6と同じ
3. CLI ツールは apt や各ツールの公式インストーラで入れる。Neovim は apt で入れず、Mac の手順5と同じやり方で入れる。ファイル名の `nvim-macos-arm64` を `nvim-linux-x86_64` に読み替える（`xattr` は不要）
4. Nix を入れる。手順は Mac の手順7と同じ

## 日々の操作

Mac の CLI ツールを足すときは `Brewfile` に書いてから `brew bundle --file ~/dotfiles/Brewfile` を実行する。
`Brewfile` と `Brewfile.local` に無いものを消すときは、まず `--force` なしで消えるものを確認してから実行する。
```sh
brew bundle cleanup --file ~/dotfiles/Brewfile          # 消えるものの一覧を出すだけ
brew bundle cleanup --file ~/dotfiles/Brewfile --force  # 実際に消す
```

設定ファイルを変えるときは `chezmoi/` 配下を編集して `chezmoi apply`。`chezmoi diff` で差分が見える。
`.zshrc` と `.zshenv` はテンプレートなので、ホームのファイルを直接編集せず `chezmoi edit ~/.zshrc` で `chezmoi/dot_zshrc.tmpl` を編集する。テンプレートでないファイルをホームで直接編集してしまったときは、`chezmoi add <ファイル>` でリポジトリ側に取り込む。

## Neovim のバージョン

Neovim は v0.12.6 に固定している。`Brewfile` には書かず、手で入れる。
上げるときは、手元で新しいバージョンを入れて設定が動くことを確かめてから、このファイルの手順のバージョンを書き換える。入れ方は Mac の手順5と同じで、`v0.12.6` の部分を新しいバージョンにする。

## つまずく箇所

- `chezmoi init` を `--source ~/dotfiles` なしで実行すると `~/.local/share/chezmoi` にもう1つ clone される
- Homebrew で Neovim を入れていたマシンでは、`brew bundle cleanup` で Homebrew の Neovim が消える一覧に出る。消してから手順5で入れ直す
- `brew bundle cleanup --force` は Homebrew で入れた cask（GUI アプリ）も消す。残したい cask は先に `Brewfile.local` に書いておく
