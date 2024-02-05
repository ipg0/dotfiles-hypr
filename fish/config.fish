if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

rvm default &> /dev/null

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
set -g __fish_git_prompt_char_upstream_diverged ' ﱟ⇄ '
set -g __fish_git_prompt_char_upstream_equal ' = '
set -g __fish_git_prompt_char_upstream_prefix ''''

bind \b backward-kill-word

thefuck --alias | source

set -Ux ANDROID_HOME /home/pyro/Android/Sdk
# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

alias clock="bigtime -fSqdn --file basic2"
alias clears="printf '\033[2J\033[3J\033[1;1H'"

set -u VIRTUAL_ENV_DISABLE_PROMPT true

source $HOME/.venv/bin/activate.fish

