# dotfiles

[tzing](https://github.com/tzing)'s personal environment configs.


## Deploy configs

```bash
task install/all
```


## Unmanaged resources

* [Homebrew](https://brew.sh/)

  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

* [Fira code](https://github.com/tonsky/FiraCode) font

  ```bash
  brew install --cask font-fira-code
  ```

* Utilities

  ```bash
  brew install \
    fzf \
    gh \
    git \
    git-delta \
    go-task \
    htop \
    kubectx \
    neovim \
    pipx \
    tmux \
    zsh
  ```

* Desktop apps

  ```bash
  brew install --cask \
    1password \
    appcleaner \
    chatgpt \
    dash \
    docker \
    drawio \
    firefox \
    ghostty \
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

    block list:

    - [danny0838/content-farm-terminator](https://danny0838.github.io/content-farm-terminator/zh/subscriptions-ublacklist)
    - [arosh/ublacklist-stackoverflow-translation](https://github.com/arosh/ublacklist-stackoverflow-translation)
    - [arosh/ublacklist-github-translation](https://github.com/arosh/ublacklist-github-translation)
