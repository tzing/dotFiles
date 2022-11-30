# dotfiles

[tzing](https://github.com/tzing)'s personal environment configs.


## Deploy configs

```bash
make install
```


## Unmanaged resources

* [Homebrew](https://brew.sh/)

  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

* [Fira code](https://github.com/tonsky/FiraCode) font

    ```bash
    brew install --cask homebrew/cask-fonts/font-fira-code
    ```

* Utilities

  ```bash
  brew install \
    fzf \
    gh \
    git \
    go-task \
    htop \
    neovim \
    tldr \
    tmux \
    zsh
  ```

* Desktop apps

  ```bash
  brew install --cask \
    docker \
    drawio \
    firefox \
    microsoft-edge \
    obsidian \
    scroll-reverser \
    spotify \
    visual-studio-code
  ```

* Firefox Addons

  * [uBlock Origin](https://addons.mozilla.org/zh-TW/firefox/addon/ublock-origin/)
  * [Multi-Account Containers](https://addons.mozilla.org/zh-TW/firefox/addon/multi-account-containers/)
  * [Facebook Container](https://addons.mozilla.org/zh-TW/firefox/addon/facebook-container/)
  * [uBlacklist](https://addons.mozilla.org/zh-TW/firefox/addon/ublacklist/)
    * block list: https://github.com/tzing/content-farm-ublacklist/

* Vim

  * [vim-plug](https://github.com/junegunn/vim-plug)

    ```bash
    vim +PlugInstall!
    ```

  * [Language server](https://github.com/prabirshrestha/vim-lsp/wiki/Servers)

    ```bash
    pip install python-language-server
    ```

* [Poetry](https://github.com/python-poetry/poetry)

  ```bash
  curl -sSL https://install.python-poetry.org | python3 -
  poetry config virtualenvs.in-project true
  ```
