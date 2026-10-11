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
5. chezmoi で設定ファイルを配置する。`--source` を付けないと `~/.local/share/chezmoi` に別途 clone されるので必ず付ける
   ```sh
   chezmoi init --source ~/dotfiles --apply
   ```
6. どうせNixを使うことになるのでインストールしておく。調べたらわかるだろうけど https://zero-to-nix.com/start/install/#run の通りに進めればいいんじゃないかな。

## Windows（WSL2）のセットアップ

1. WSL2 と Ubuntu を入れる。PowerShell で `wsl --install`
2. WSL の中でこのリポジトリを clone し、chezmoi を入れて設定ファイルを置く。手順は Mac の手順5と同じ
3. CLI ツールは apt や各ツールの公式インストーラで入れる
4. Nix を入れる。手順は Mac の手順6と同じ

## 日々の操作

Mac の CLI ツールを足すときは `Brewfile` に書いてから `brew bundle --file ~/dotfiles/Brewfile` を実行する。
`Brewfile` と `Brewfile.local` に無いものを消すときは、まず `--force` なしで消えるものを確認してから実行する。
```sh
brew bundle cleanup --file ~/dotfiles/Brewfile          # 消えるものの一覧を出すだけ
brew bundle cleanup --file ~/dotfiles/Brewfile --force  # 実際に消す
```

設定ファイルを変えるときは `chezmoi/` 配下を編集して `chezmoi apply`。`chezmoi diff` で差分が見える。
`.zshrc` と `.zshenv` はテンプレートなので、ホームのファイルを直接編集せず `chezmoi edit ~/.zshrc` で `chezmoi/dot_zshrc.tmpl` を編集する。テンプレートでないファイルをホームで直接編集してしまったときは、`chezmoi add <ファイル>` でリポジトリ側に取り込む。

## つまずく箇所

- `chezmoi init` を `--source ~/dotfiles` なしで実行すると `~/.local/share/chezmoi` にもう1つ clone される
- `brew bundle cleanup --force` は Homebrew で入れた cask（GUI アプリ）も消す。残したい cask は先に `Brewfile.local` に書いておく
