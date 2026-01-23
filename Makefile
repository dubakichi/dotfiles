# 変数定義（後で変更しやすいように）
DOTFILES_DIR := $(shell pwd)
BREWFILE := homebrew/.Brewfile

# デフォルトターゲット
# ただ 'make' と打っただけで、初期化・リンク・インストール全てを行う
all: init link brew

# 1. 初期化: Homebrew と Stow のインストール
init:
	@echo "==> Initializing..."
	@# Homebrewが入っていない場合のみインストール
	@command -v brew >/dev/null 2>&1 || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@# Stowが入っていない場合のみインストール
	@command -v stow >/dev/null 2>&1 || brew install stow

# 2. リンク: GNU Stow を使ってシンボリックリンクを作成
link:
	@echo "==> Linking dotfiles..."
	@# zshディレクトリの中身をホームディレクトリに展開
	stow --verbose --target=$$HOME --restow zsh
	stow --verbose --target=$$HOME --restow helix
	stow --verbose --target=$$HOME --restow ghostty

# 3. インストール: Brewfile からパッケージをインストール
brew:
	@echo "==> Installing Homebrew packages..."
	@# 指定されたBrewfileを使ってインストールを実行
	brew bundle --file=$(BREWFILE)

# お掃除用: リンクを削除したい時
clean:
	@echo "==> Cleaning up links..."
	stow --verbose --target=$$HOME --delete zsh

# Phonyターゲット（同名のファイルがディレクトリ内にあってもコマンドとして実行させる）
.PHONY: all init link brew clean

