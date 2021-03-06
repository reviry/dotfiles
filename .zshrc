#┌─┐┌─┐┬ ┬┬─┐┌─┐
#┌─┘└─┐├─┤├┬┘│
#└─┘└─┘┴ ┴┴└─└─┘


##########################################
# Basic settings
##########################################
# autoload
autoload -U compinit && compinit
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload history-search-end
autoload -Uz add-zsh-hook
autoload -Uz terminfo

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

export PATH=$HOME/.nodebrew/current/bin
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

export PATH=$PATH:$HOME/.rbenv/bin

# source-highlight
export LESSOPEN='| $HOME/.source-highlight/src-hilite-lesspipe.sh %s'
export LESS='-R'

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$PYENV_ROOT/shims:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH=$PATH:$HOME/.local/bin

# Added by the Heroku Toolbelt
export PATH=$PATH:/usr/local/heroku/bin

export R_HOME=/usr/bin/R
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

export PATH=$PATH:~/Qt5.5.1/5.5/clang_64/bin

# rbenv
eval "$(rbenv init -)"

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

# Setup fzf
source ~/.zplug/repos/junegunn/fzf/shell/completion.zsh
source ~/.zplug/repos/junegunn/fzf/shell/key-bindings.zsh
# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
_fzf_compgen_path() {
  ag --hidden --ignore .git -g "" "$1"
}


##########################################
# Appearance
##########################################
# prompt
setopt prompt_subst
zstyle ':vcs_info:*' formats ' (%F{green}%b%f)'
zstyle ':vcs_info:*' actionformats ' (%F{red}%b(%a)%f)'
precmd() { vcs_info }

venv() {
  if [[ -n $VIRTUAL_ENV ]]; then
    VENV="(${VIRTUAL_ENV:t}) "
  else
    VENV=""
  fi
}

PROMPT_2=$'[%{${fg[cyan]}%}%n@%m:%~%{${reset_color}%}${vcs_info_msg_0_}]\n$VENV$ '

terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]$terminfo[cud1]
left_down_prompt_preexec() {
    print -rn -- $terminfo[el]
}
add-zsh-hook preexec left_down_prompt_preexec
add-zsh-hook precmd venv

function zle-line-init zle-keymap-select
{
  case $KEYMAP in
    main|viins)
      VIMODE="$fg[yellow]-- INSERT --$reset_color"
      ;;
    vicmd)
      VIMODE="$fg[cyan]-- NORMAL --$reset_color"
      ;;
  esac

  PROMPT="%{$terminfo_down_sc$VIMODE$terminfo[rc]%}$PROMPT_2"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select


##########################################
# Alias settings
##########################################
alias ls="ls -GF"
alias rs="bundle exec rails s"
alias rc="bundle exec rails c"
alias ctags="`brew --prefix`/bin/ctags"
alias diff="colordiff -u"
# alias vim="nvim"


##########################################
# Commands
##########################################
# git commit browser (enter for show, ctrl-d for diff)
fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
        --print-query --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}

# fuzzy git add
fadd() {
  local out q n addfiles
  while out=$(
      git status --short |
      awk '{if (substr($0,2,1) !~ / /) print $2}' |
      fzf-tmux --multi --exit-0 --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    addfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$addfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      git diff --color=always $addfiles | less -R
    else
      git add $addfiles
    fi
  done
}

# Change tmux session
fs() {
  local session
  session=$(tmux ls -F "#{session_name}" > /dev/null | fzf-tmux --reverse +m) &&
    tmux switch-client -t $session
  precmd
  zle reset-prompt
}

# ghq + fzf
frepo() {
  local dir
  dir=$(ghq list > /dev/null | fzf-tmux --reverse +m) &&
    builtin cd $(ghq root)/$dir
  precmd
  zle reset-prompt
}
zle -N frepo

# search code playground
fp() {
  local dir
  dir=$(find ~/code -type d -maxdepth 2 > /dev/null | fzf-tmux --reverse) &&
    builtin cd $dir
  precmd
  zle reset-prompt
}
zle -N fp


##########################################
# Key bindings
##########################################
# keybind like vi
bindkey -v

# Vim-like escaping jj keybind
bindkey -M viins 'jj' vi-cmd-mode

# Add emacs-like keybind to viins mode
bindkey -M viins '^F'  forward-char
bindkey -M viins '^B'  backward-char
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^K'  kill-line
bindkey -M viins '^Y'  yank
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^H'  backward-delete-char

# Add emacs-like keybind to viins mode
bindkey -M vicmd '^A'  beginning-of-line
bindkey -M vicmd '^E'  end-of-line
bindkey -M vicmd '^K'  kill-line
bindkey -M vicmd '^W'  backward-kill-word
bindkey -M vicmd '^U'  backward-kill-line

# search history
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# search local repository
bindkey '^G' frepo

# search code playground
bindkey '^J' fp

##########################################
# Others
##########################################
# tmux session attach
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
      echo "${fg[cyan]} ─┬───┐         ─┬───┐     ${reset_color}"
      echo "${fg[cyan]}  │   │          │   │     ${reset_color}"
      echo "${fg[cyan]}  ├──┬┘┌─┐┬  ┬ ┬┬├──┬┘┬ ┬  ${reset_color}"
      echo "${fg[cyan]}  │  │ ├┤ └┐┌┘ │││  │ └┬┘  ${reset_color}"
      echo "${fg[cyan]} ─┴──└─└─┘ └┘ ─┴┴┴──└─ ┴   ${reset_color}"
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

# Setup ssh-agent
if [ -f ~/.ssh-agent ]; then
  . ~/.ssh-agent
fi
if [ -z "$SSH_AGENT_PID" ] || ! kill -0 $SSH_AGENT_PID; then
  ssh-agent > ~/.ssh-agent
  . ~/.ssh-agent
fi
ssh-add -l >& /dev/null || ssh-add

#################################
# zplug
################################

if [[ -f ~/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh

  zplug "zplug/zplug"

  zplug "b4b4r07/enhancd", \
    use:init.sh

  zplug "zsh-users/zsh-history-substring-search"

  zplug "zsh-users/zsh-syntax-highlighting", \
    defer:2

  zplug "zsh-users/zsh-completions"

  zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
  zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/google-cloud-sdk/completion.zsh.inc'; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/yuki/.nodebrew/node/v7.7.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/yuki/.nodebrew/node/v7.7.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/yuki/.nodebrew/node/v7.7.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/yuki/.nodebrew/node/v7.7.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
