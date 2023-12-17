set -l ghcup $HOME/.ghcup

set -q GHCUP_INSTALL_BASE_PREFIX
and set ghcup $GHCUP_INSTALL_BASE_PREFIX/.ghcup

if test -f $ghcup/env
    contains -- $ghcup/bin
    or fish_add_path -pmP $ghcup/bin
end

contains -- $HOME/.cabal/bin $fish_user_paths
or fish_add_path -pmP $HOME/.cabal/bin

contains -- $HOME/.local/bin $fish_user_paths
or fish_add_path -pmP $HOME/.local/bin
