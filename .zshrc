#
# ███████╗███████╗██╗  ██╗██████╗  ██████╗
# ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#   ███╔╝ ███████╗███████║██████╔╝██║
#  ███╔╝  ╚════██║██╔══██║██╔══██╗██║
# ███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#


# autoload
autoload -U compinit && compinit
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload history-search-end

# language
export LANG=ja_JP.UTF-8

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# ls command colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

export PATH=/usr/local/bin:/usr/local/sbin/:/usr/bin:/bin:/usr/sbin:/sbin

export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

export PATH=$PATH:$HOME/.rbenv/bin

export PATH=$PATH:$HOME/.nodebrew/current/bin

# golang
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

# Added by the Heroku Toolbelt
export PATH=$PATH:/usr/local/heroku/bin

export R_HOME=/usr/bin/R
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

export DJANGO_SETTINGS_MODULE="mb_2.settings.development"

# rbenv
eval "$(rbenv init -)"

# prompt
setopt prompt_subst
zstyle ':vcs_info:*' formats '%F{green}[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}[%b(%a)]%f'
precmd() { vcs_info }
PROMPT='%{${fg[blue]}%}[%~]%{${reset_color}%}
%{${fg[yellow]}%}[%n@%m]%{${reset_color}%}${vcs_info_msg_0_}'

# ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' list-colors "${LS_COLORS}"

# cd
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# check spell
setopt correct

# does not exit zsh by C-d
setopt ignore_eof

# no beep
setopt no_beep

# share History
setopt share_history

# Delete an old recorded event if a new event is a duplicate.
setopt hist_ignore_all_dups
setopt hist_save_nodups

# Confirm when executing 'rm *'
setopt rm_star_wait

# keybind like emacs
bindkey -e

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[P" history-beginning-search-backward-end
bindkey "^[N" history-beginning-search-forward-end

# Alias settings
alias ls="ls -GF"
alias rs="bundle exec rails s"
alias rc="bundle exec rails c"

# ghq + fzf
function frepo() {
  local dir
  dir=$(ghq list > /dev/null | fzf-tmux --reverse +m) &&
    builtin cd $(ghq root)/$dir
  precmd
  zle reset-prompt
}
zle -N frepo
bindkey '^G' frepo

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


#################################
# zplug
################################

if [[ -f ~/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh

  zplug "zplug/zplug"

  zplug "b4b4r07/enhancd", \
    use:init.sh

  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    else
      echo
    fi
  fi
  zplug load --verbose
fi
