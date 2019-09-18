# dotfiles

:wrench: my personal environment configs


## cheatsheet

+ vim :notebook:
    + install: `vim +PlugInstall`

+ tmux
    + toggle start/stop logging: prefix + `shift` + `p` (*tmux-logging*)
    + save complete pane history: prefix + `alt` + `shift` + `p` (*tmux-logging*)
    + search: prefix + `/` (*tmux-copycat*)


## dependency

+ system :computer:
    + `git`
    + `zsh` 5.4+

+ syntax highlight for less (select one)
    + [pygments](http://pygments.org/docs/cmdline/)
    + [source highlight](https://www.gnu.org/software/src-highlite/)

+ *tmux-yank* :paperclip:
    + [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard) (osx)
    + `xsel` or `xclip` (linux)

+ *git-ilog*
    + [fzf](http://zsh.sourceforge.net/)
    + `xsel` or `xclip` (linux)


## quick link

- language server for vim (from *vim-lsp*)
    + https://github.com/prabirshrestha/vim-lsp/wiki/Servers
    + for python

        ```sh
        pip install python-language-server
        ```

+ [Fira Code font](https://github.com/tonsky/FiraCode)
