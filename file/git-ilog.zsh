#! /usr/bin/env zsh

# log format
local git_log_format_components=(
	'%C(auto)'
	'%h'  # abbreviated commit hash
	'%d'  # ref name(s)
	' '
	'%s'  # subject
	' '
	'%C(green)'
	'%cr'  # relative committer date
	'%C(reset)'
)
local git_log_format="${(j..)git_log_format_components}"

# helper: get commit id
local get_commit_id="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"

# helper: syntax highlighter
local syntax_highlighter=''
if type delta > /dev/null; then
	syntax_highlighter='| delta'
fi

# helper: show content
local view_commit="xargs -I% git show --color=always % -- $syntax_highlighter"

# run
git log "$@" \
	--graph \
	--color=always \
	--format="$git_log_format" \
| fzf \
	--no-sort \
	--reverse \
	--tiebreak=index \
	--ansi \
	--preview "$get_commit_id | $view_commit" \
	--bind "enter:execute:$get_commit_id | tee > /dev/stderr | $view_commit" \
|| true
