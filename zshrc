
activate-pyenv () {
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
}

activate-nvm () {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

autoload -Uz compinit
compinit

_bb_tasks() {
    local matches=(`bb tasks |tail -n +3 |cut -f1 -d ' '`)
    compadd -a matches
    _files # autocomplete filenames as well
}
compdef _bb_tasks bb

alias gemacs='open /Applications/Emacs.app'

stty discard undef  # Clears ^O, doesn't block remapped Tmux prefix key.
stty dsusp undef  # Clears ^Y, doesn't block Emacs yank command.
stty stop undef  # Clears ^S, doesn't block Emacs incremental search command.
stty lnext undef # Clears ^V, doesn't block Emacs scroll down page command.

zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
