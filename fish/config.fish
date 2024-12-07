# disable default message
set fish_greeting

# git statusline in prompt
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showupstream informative
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_cleanstate ' ✔ '
set -g __fish_git_prompt_char_dirtystate ' ✚ '
set -g __fish_git_prompt_char_invalidstate ' ✖ '
set -g __fish_git_prompt_char_stagedstate ' ● '
set -g __fish_git_prompt_char_stashstate ' ⚑ '
set -g __fish_git_prompt_char_untrackedfiles ' ? '
set -g __fish_git_prompt_char_upstream_ahead ' ↑ '
set -g __fish_git_prompt_char_upstream_behind ' ↓ '
set -g __fish_git_prompt_char_upstream_diverged ' ⇄ '
set -g __fish_git_prompt_char_upstream_equal ' = '
set -g __fish_git_prompt_char_upstream_prefix ''''

# rvm
rvm default &>/dev/null

# ctrl + backspace = erase word
bind \b backward-kill-word

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# volta
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# open a digital clock in the terminal
alias clock="bigtime -fSqd --file basic2"

# clear both terminal and scrollback buffer
alias clears="printf '\033[2J\033[3J\033[1;1H'"

# for scripts using standalone docker-compose
alias docker-compose='docker compose'

# zoxide
zoxide init fish | source

# batcat
alias cat="bat"
alias pcat="cat -pp"
set --export MANROFFOPT -c
set --export MANPAGER "sh -c 'col -bx | bat -l man -p'"
set --export BAT_THEME base16

# because I am an extension junkie, a VSCode fanboy and a masochist
set --export EDITOR code

# cd through Zoxide using Yazi
# because why not
alias cx="z (yazi --chooser-file=/dev/stdout | while read; echo; end;)"

# cd to current directory's actual location
alias cl="cd (readlink -f .)"

# since the default option for rm is to drop the fucking nukes
alias "fuck-off-and-rm"="/bin/rm"
alias "fuck-off-and-rmdir"="/bin/rmdir"
alias rm="rmtrash"
alias rmdir="rmdirtrash"
alias sudo="sudo "
# so I never call rm -rf ./* by accident (again)

# because it broke for some reason
alias haskell-language-server="haskell-language-server-wrapper"

# so venv doesn't mess up my prompt
set -u VIRTUAL_ENV_DISABLE_PROMPT true

# activate venv
source $HOME/.venv/bin/activate.fish

# Python is a toy programming language,
# a minor version breaks this package

# thefuck --alias | source

# some crutch for work, I don't remember why it's here
set --export GOPATH /home/pyro/go
