# bind key
bind Left       previous-window
bind Right      next-window
bind A          command-prompt "rename-window %%"
bind R          move-window -r
bind S          command-prompt "rename-session %%"
bind M          command-prompt "move-window -t %%"

bind i          select-pane -U
bind k          select-pane -D
bind j          select-pane -L
bind l          select-pane -R

bind C-i        resize-pane -U 2
bind C-k        resize-pane -D 2
bind C-j        resize-pane -L 2
bind C-l        resize-pane -R 2

# copying text from screen
run-shell "~/.config/tmux/tmux-yank/yank.tmux"

set -g @yank_selection 'primary'
unbind-key -T copy-mode-vi MouseDragEnd1Pane

# misc
set -g mouse on

# Powerline Cyan Block - Tmux Theme: https://github.com/jimeh/tmux-themepack
# Status update interval
set -g status-interval 1

# Basic status bar colors
set -g status-style fg=colour240,bg=colour233

# Left side of status bar
set -g status-left-style bg=colour233,fg=colour243
set -g status-left-length 40
set -g status-left "#[fg=colour232,bg=colour39,bold] #S #[fg=colour39,bg=colour240,nobold]#[fg=colour233,bg=colour240] #(whoami) #[fg=colour240,bg=colour235]#[fg=colour240,bg=colour235] #I:#P #[fg=colour235,bg=colour233,nobold]"

# Right side of status bar
set -g status-right-style bg=colour233,fg=colour243
set -g status-right-length 150
set -g status-right "#[fg=colour235,bg=colour233]#[fg=colour240,bg=colour235] %H:%M:%S %z #[fg=colour240,bg=colour235]#[fg=colour233,bg=colour240] %d-%b-%y #[fg=colour245,bg=colour240]#[fg=colour232,bg=colour245,bold] #H "

# Window status
set -g window-status-format " #I:#W#F "
set -g window-status-current-format " #I:#W#F "

# Current window status
set -g window-status-current-style bg=colour39,fg=colour232

# Window with activity status
set -g window-status-activity-style bg=colour233,fg=colour75

# Window separator
set -g window-status-separator ""

# Window status alignment
set -g status-justify centre

# Pane border
set -g pane-border-style bg=default,fg=colour238

# Active pane border
set -g pane-active-border-style bg=default,fg=colour39

# Pane number indicator
set -g display-panes-colour colour233
set -g display-panes-active-colour colour245

# Clock mode
set -g clock-mode-colour colour39
set -g clock-mode-style 24

# Message
set -g message-style bg=colour39,fg=black

# Command message
set -g message-command-style bg=colour233,fg=black

# Mode
set -g mode-style bg=colour39,fg=colour232

# tmux-sensible
run-shell "~/.config/tmux/tmux-sensible/sensible.tmux"
