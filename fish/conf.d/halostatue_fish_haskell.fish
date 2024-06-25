set --local ghcup $HOME/.ghcup

set --query GHCUP_INSTALL_BASE_PREFIX
and set ghcup $GHCUP_INSTALL_BASE_PREFIX/.ghcup

if test -f $ghcup/env && not contains -- $ghcup/bin $fish_user_paths
    fish_add_path --prepend --move --path $ghcup/bin
end

if not contains -- $HOME/.cabal/bin $fish_user_paths
    fish_add_path --prepend --move --path $HOME/.cabal/bin
end

if not contains -- $HOME/.local/bin $fish_user_paths
    fish_add_path --prepend --move --path $HOME/.local/bin
end
