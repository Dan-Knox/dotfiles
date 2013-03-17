#!/usr/bin/env zsh

backup_dir=".dotfile_backup"

pushd $HOME

  mkdir -p $backup_dir

  pushd $HOME/dotfiles

    for file in $(ls *(.)); do
      if [[ $file == bootstrap.zsh ]]; then
        continue
      fi

      if [[ $file == bin ]]; then
        continue
      fi

      # Allow for skipping the .gitconfig for
      # situations like work.
      if [[ $file == gitconfig ]]; then
        echo "Copy git config? (y/n): "
        read answer
        if [ $answer = "n" ]; then
          continue
        fi
      fi

      dotfile="${HOME}/.${file}"

      if [ -f $dotfile ]; then
        mv $HOME/.$file $HOME/$backup_dir
      fi

      ln -s $HOME/dotfiles/$file $HOME/.$file
    done

  popd
popd
