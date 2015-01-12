#! /bin/bash

BASH_HOME=$(pwd)
IP=$(ipconfig getifaddr en1)
USERDATA=(name email)
IMAC=(Alan-iMac alan.moment77@gmail.com)
UNALIS=(alan.chen alan.chen@unalis.com.tw)


function setup_gitconfig() {
	MY[0]=${IMAC[0]}
	MY[1]=${IMAC[1]}
	[ "${IP}" != "192.168.1.50" ] && MY[0]=${UNALIS[0]} && MY[1]=${UNALIS[1]}
	if [ ! -f "$BASH_HOME/gitconfig" ]; then
		FILE=$BASH_HOME/gitconfig
		touch $FILE
		echo "[user]" >> $FILE
		for ((i=0; i<${#MY[@]}; i++)); do
			echo "        ${USERDATA[$i]} = ${MY[$i]}" >> $FILE
		done
		echo "[core]" >> $FILE
		echo "		quotepath = false # chinese file" >> $FILE
    echo "		editor = /usr/bin/vim # fix error: There was a problem with the editor 'vi'" >> $FILE
		echo "[color]" >> $FILE
		echo "		diff = auto" >> $FILE
		echo "		status = auto" >> $FILE
		echo "		branch = auto" >> $FILE
		echo "		log = auto" >> $FILE
		echo "		ui = auto" >> $FILE
		echo "[alias]" >> $FILE
		echo "		co = checkout" >> $FILE
		echo "		ci = commit" >> $FILE
		echo "		st = status" >> $FILE
		echo "		br = branch" >> $FILE
		echo "		mg = merge --no-ff" >> $FILE
		echo "[push]" >> $FILE
		echo "		default = simple" >> $FILE
	fi
}

function setup_gitdiff() {
	FILE=$BASH_HOME/plugins/git-diff-wrapper.sh
	if [ -f $FILE ]; then
		return
	fi
	touch $FILE
	echo "#!/bin/bash" >> $FILE
	echo "$BASH_HOME/icdiff \$2 \$5" >> $FILE
	chmod +x $FILE

	curl -s https://raw.githubusercontent.com/jeffkaufman/icdiff/release-1.7.2/icdiff > $BASH_HOME/plugins/icdiff
	chmod +x $BASH_HOME/plugins/icdiff

	echo "" >> $BASH_HOME/extra_bash_profile
	echo "# git diff alias" >> $BASH_HOME/extra_bash_profile
	echo "alias icdiff=$BASH_HOME/plugins/icdiff --highlight" >> $BASH_HOME/extra_bash_profile

	FILE=$BASH_HOME/gitconfig
	echo "[diff]" >> $FILE
	echo "		external = $BASH_HOME/plugins/git-diff-wrapper.sh" >> $FILE
}

function setup_gitpush() {
	filename="$BASH_HOME/extra_bash_profile"
	exec < $filename
	WRITE=true
	while read line
	do
		[[ `echo "${line}" | grep "^alias git-push *"` ]] && WRITE=false
	done

	if [[ -f "$BASH_HOME/plugins/git-push-remote-option.sh" && $WRITE == true ]]; then
		chmod a+x plugins/git-push-remote-option.sh
		echo "" >> $BASH_HOME/extra_bash_profile
		echo "# git push menu alias" >> $BASH_HOME/extra_bash_profile
		echo "alias git-push=sh $BASH_HOME/plugins/git-push-remote-option.sh" >> $BASH_HOME/extra_bash_profile
	fi
}

function green_text() {
	green='\e[0;32m'
	printf "${green} $1 \33[0m\n"
}

function setup_vim() {
	git submodule add https://github.com/drmikehenry/vimfiles.git $BASH_HOME/vim
  git submodule init
	git submodule update
}

function setup_softlink() {
	ln -sf $BASH_HOME/vim $HOME/.vim
	ln -sf $BASH_HOME/vim/vimrc $HOME/.vimrc
	ln -sf $BASH_HOME/gvimrc $HOME/.gvimrc
	ln -sf $BASH_HOME/gitconfig $HOME/.gitconfig
}

# 將自定的command載入.bashrc
# 先檢查有無.bashrc
function setup_bashrc() {
	if [ ! -f "$HOME/.bash_profile" ]; then
		touch $HOME/.bash_profile
	fi

	filename="$HOME/.bash_profile"
	exec < $filename
	WRITE=true
	while read line
	do
		[[ `echo "${line}" | grep "^# Auto *"` ]] && WRITE=false
	done

	if [[ -f "$HOME/.bash_profile" && $WRITE == true ]]; then
		echo "" >> $HOME/.bash_profile
		echo '# Auto load my default config' >> $HOME/.bash_profile
		echo 'export BASH_HOME='"${BASH_HOME}" >> $HOME/.bash_profile
		echo '[[ -f "${HOME}/.bash_profile" ]] && source "$BASH_HOME/bash_profile"' >> $HOME/.bash_profile
		source $HOME/.bash_profile
	fi
	#[[ -f "$HOME/.bash_profile" && $WRITE == true ]] && echo '\n\n[[ -f "${HOME}/.bash_profile" ]] && source "$BASH_HOME/bash_profile"' >> $HOME/.bash_profile
}

function setup() {
	if [ ! -f "$BASH_HOME/extra_bash_profile" ]; then
		touch "$BASH_HOME/extra_bash_profile"
	fi

	green_text "Auto setup is started"

	setup_gitconfig
	green_text "[gitconfig] is created"

	setup_gitdiff
	green_text "[git diff] is created"

	setup_gitpush
	green_text "[git push] is created"

	setup_vim
	green_text "[vim] is created"

	setup_softlink
	green_text "[softlink] is created"

	setup_bashrc
	green_text "Auto setup is finished"

	echo "Please login again"
}

# execute
setup
