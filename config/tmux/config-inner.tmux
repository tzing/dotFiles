# load base configs
source-file ~/.config/tmux/config.tmux

# overwrite theme
# Powerline Gray Block - Tmux Theme
set -g status-style fg=colour238,bg=colour233
set -g status-left "#[fg=colour232,bg=colour245,bold] #S #[fg=colour245,bg=colour240,nobold]#[fg=colour233,bg=colour240] #(whoami) #[fg=colour240,bg=colour235]#[fg=colour240,bg=colour235] #I:#P #[fg=colour235,bg=colour233,nobold]"
set -g window-status-current-style bg=colour245,fg=colour232
set -g window-status-activity-style bg=colour233,fg=colour245
set -g pane-border-style bg=default,fg=colour235
set -g pane-active-border-style bg=default,fg=colour240
set -g clock-mode-colour colour240
set -g message-style bg=colour245,fg=colour232
set -g message-command-style bg=colour233,fg=colour250
set -g mode-style bg=colour243,fg=colour232

# overwrite prefix
set -g prefix C-g
