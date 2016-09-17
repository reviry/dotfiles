export PATH=/usr/local/bin:/usr/local/sbin/:/usr/bin:/bin:/usr/sbin:/sbin

export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

export PATH=$PATH:$HOME/.rbenv/bin

export PATH=$PATH:$HOME/.nodebrew/current/bin

export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

### Added by the Heroku Toolbelt
export PATH=$PATH:/usr/local/heroku/bin

export R_HOME=/usr/bin/R
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

eval "$(rbenv init -)"
alias rs="bundle exec rails s"
alias rc="bundle exec rails c"

alias mvim="mvim --remote-tab-silent"

# ------------------------------
# Git Aliases
# ------------------------------
# source /usr/local/etc/bash_completion.d/git-prompt.sh
# source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\h\[\033[00m\]:\W\[\033[31m\]$(__git_ps1 [%s])\[\033[00m\]\$ '
alias glog='git log --oneline --graph'
#-------------------------------
set completion-ignore-case on

# zstyle ':completion:*:*:git:*' script ~/.zsh/completion/git-completion.bash
# fpath=(~/.zsh/completion $fpath)
#
# autoload -U compinit
# compinit -u

export LANG=ja_JP.UTF-8
export DJANGO_SETTINGS_MODULE="mb_2.settings.development"

autoload -Uz colors
colors

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats '%F{green}[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}[%b(%a)]%f'
precmd() { vcs_info }
PROMPT='%{${fg[blue]}%}[%~]%{${reset_color}%}
%{${fg[yellow]}%}[%n@%m]%{${reset_color}%}${vcs_info_msg_0_}'

#補完機能
autoload -U compinit; compinit
setopt list_packed
#大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#補完でカラーを使用する
zstyle ':completion:*' list-colors "${LS_COLORS}"

# autoload predict-on
# predict-on

# ディレクトリ名だけでcdする
setopt auto_cd
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

setopt correct

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# beep を無効にする
setopt no_beep

# 同時に起動したzshの間でヒストリを共有する
setopt share_history
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

bindkey -e
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
            echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
            echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
            echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
            echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session
