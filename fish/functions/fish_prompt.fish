# ░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█░░░█▀█░█▀▀░█░█░█▀▀
# ░█▀▀░░█░░▀▀█░█▀█░█▀▄░█░░░█░█░█░░░█▀▄░▀▀█
# ░▀░░░▀▀▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
#
# A dead simple fishshell prompt
# Created by Gerome Matilla

# ░█░█░█▀▀░█░░░█▀█░█▀▀░█▀▄░█▀▀
# ░█▀█░█▀▀░█░░░█▀▀░█▀▀░█▀▄░▀▀█
# ░▀░▀░▀▀▀░▀▀▀░▀░░░▀▀▀░▀░▀░▀▀▀

# Is git dirty?
function _fishblocks_git_dirty -d 'Checks whether or not the current branch has tracked, modified files'
	not git diff --no-ext-diff --quiet --exit-code 2>/dev/null && echo 0
end

# Is git has untracked files?
function _fishblocks_git_untracked -d 'Checks whether or not the current repository has untracked files'
	command git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- :/ >/dev/null 2>&1 &&
		echo 0
end

# Is PWD a git directory?
function _fishblocks_git_directory -d 'Checks whether or not the current directory is a or part of a git repository'
	set -l repo_info (command git rev-parse --git-dir --is-inside-git-dir --is-bare-repository --is-inside-work-tree HEAD 2>/dev/null)
	echo $repo_info
end

# Set git status color
function _fishblocks_git_status -d 'Returns color based on the previous command status'
	if [ (_fishblocks_git_directory) ]
		if [ (_fishblocks_git_untracked) ] &&  not [ (_fishblocks_git_dirty) ]
			set git_color brgreen
		else if [ (_fishblocks_git_dirty) ]
			set git_color yellow
		else
			set git_color green
		end
	else
		set git_color white
	end
	echo $git_color
end

# OS type
function _fishblocks_os_type -d 'Returns OS type'
	set os_type (sh -c "echo \$OSTYPE")
	echo $os_type
end

# Distro name
function _fishblocks_distro_name -d 'Returns linux distribution name'
	set distro_name
	if test -z $distro_name && test -r /etc/os-release
		set distro_name (awk -F '=' '$1=="ID" { print $2 ;}' /etc/os-release)
	end
	if test -z $distro_name && test -r /usr/lib/os-release
		set distro_name (awk -F '=' '$1=="ID" { print $2 ;}' /usr/lib/os-release)
	end
	if test -z $distro_name && [ (command -v lsb_release) ]
		set distro_name (lsb_release -i)
	end
	if test -z $distro_name
		set distro_name 'unknown'
	end
	set distro_name (string lower $distro_name)
	echo $distro_name
end

# ░█▀▄░█░░░█▀█░█▀▀░█░█░█▀▀
# ░█▀▄░█░░░█░█░█░░░█▀▄░▀▀█
# ░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀

# SSH block
function _block_ssh -d 'Returns SSH block'
	set block
	if set -q SSH_TTY
		set block (set_color -b bryellow -o black)' SSH '
	end
	echo $block
end

# user@host block
function _block_user_host -d 'Returns username and hostname block'
	set -l user_hostname $USER@(prompt_hostname)
	if [ $USER = 'root' ]
		set user_bg red
	else if [ $USER != (logname) ]
		set user_bg yellow
	else
		set user_bg white
	end
	
	# If we're running via SSH.
	if set -q SSH_TTY
		set user_bg brblack
		set user_hostname (set_color -o brblue)$USER(set_color -o brred)@(set_color -o brgreen)(prompt_hostname)
	end

	set block (set_color -b $user_bg -o black)' '$user_hostname' '
	echo $block
end

# PWD block
function _block_pwd -d 'Returns PWD block'
	# Check working directory if writable
	if test -w $PWD
		set pwd_color (_fishblocks_git_status)
	else
		set pwd_color red
	end
	set block (set_color -b black -o $pwd_color)' '(prompt_pwd)' '(set_color -b normal black)\uE0B8
	echo $block
end

# ░█░░░█▀▀░█▀▀░▀█▀░░░░░█░█░█▀█░█▀█░█▀▄░░░█▀█░█▀▄░█▀█░█▄█░█▀█░▀█▀
# ░█░░░█▀▀░█▀▀░░█░░▄▄▄░█▀█░█▀█░█░█░█░█░░░█▀▀░█▀▄░█░█░█░█░█▀▀░░█░
# ░▀▀▀░▀▀▀░▀░░░░▀░░░░░░▀░▀░▀░▀░▀░▀░▀▀░░░░▀░░░▀░▀░▀▀▀░▀░▀░▀░░░░▀░

function fish_prompt
	# Window title
	switch $TERM;
		case xterm'*' vte'*';
			echo -ne '\033]0;[ '(prompt_pwd)' ]\007';
		case screen'*';
			echo -ne '\033k[ '(prompt_pwd)' ]\033\\';
	end

	# Print right-hand prompt
	echo (_block_ssh)(_block_pwd)(set_color normal)' '
end
