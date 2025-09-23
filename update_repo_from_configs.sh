#!/bin/zsh

echo "-----> Updating dotfiles repo files from current config files..."

for name in aliases gitconfig irbrc rspec zprofile zshrc; do
  src="$HOME/.$name"
  dest="$PWD/$name"
  if [ -e "$src" ] && [ ! -L "$src" ]; then
    echo "-----> Copying $src to $dest"
    cp "$src" "$dest"
  else
    echo "-----> Skipping $src (not a regular file or does not exist)"
  fi
done

if [[ `uname` =~ "Darwin" ]]; then
  CODE_PATH=~/Library/Application\ Support/Code/User
else
  CODE_PATH=~/.config/Code/User
  if [ ! -e $CODE_PATH ]; then
    CODE_PATH=~/.vscode-server/data/Machine
  fi
fi

for name in settings.json keybindings.json snippets; do
  src="$CODE_PATH/$name"
  dest="$PWD/$name"
  if [ -e "$src" ] && [ ! -L "$src" ]; then
    echo "-----> Copying $src to $dest"
    cp -r "$src" "$dest"
  else
    echo "-----> Skipping $src (not a regular file or does not exist)"
  fi
done

if [[ `uname` =~ "Darwin" ]]; then
  src="$HOME/.ssh/config"
  dest="$PWD/config"
  if [ -e "$src" ] && [ ! -L "$src" ]; then
    echo "-----> Copying $src to $dest"
    cp "$src" "$dest"
  else
    echo "-----> Skipping $src (not a regular file or does not exist)"
  fi
fi

# Copy hypr and waybar config folders on Linux
if [[ "$(uname -s)" == "Linux" ]]; then
  for config_dir in hypr waybar; do
    src="$HOME/.config/$config_dir"
    dest="$PWD/$config_dir"
    if [ -d "$src" ]; then
      echo "-----> Copying directory $src to $dest"
      rm -rf "$dest"
      cp -r "$src" "$dest"
    else
      echo "-----> Skipping $src (directory does not exist)"
    fi
  done
fi

echo "👌 Dotfiles repository updated from current config files."
