#┌─┐┌─┐┬ ┬┬─┐┌─┐
#┌─┘└─┐├─┤├┬┘│
#└─┘└─┘┴ ┴┴└─└─┘


##########################################
# Basic settings
##########################################
# autoload
autoload -U compinit && compinit
# autoload -Uz compinit && compinit -u
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload history-search-end
autoload -Uz add-zsh-hook
autoload -Uz terminfo

# language
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# history
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# git
export PATH=$PATH:/opt/homebrew/opt/git/share/git-core/contrib/diff-highlight

# source-highlight
export LESSOPEN='| /opt/homebrew/opt/source-highlight/bin/src-hilite-lesspipe.sh %s'
export LESS='-R'

# anyenv
eval "$(anyenv init -)"

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# poetry
export PATH=$PATH:$HOME/.local/bin
fpath+=~/.zfunc

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

# share history
setopt share_history

# delete an old recorded event if a new event is a duplicate.
setopt hist_ignore_all_dups
setopt hist_save_nodups

# confirm when executing 'rm *'
setopt rm_star_wait

# fzf
source ~/.zplug/repos/junegunn/fzf/shell/completion.zsh
source ~/.zplug/repos/junegunn/fzf/shell/key-bindings.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
_fzf_compgen_path() {
  ag --hidden --ignore .git -g "" "$1"
}

# zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c6c6c"

# starship
eval "$(starship init zsh)"

# completion
zstyle ':completion:*:default' menu select=2

zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'
zstyle ':completion:*' group-name ''

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

zmodload -i zsh/complist
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char


##########################################
# Alias settings
##########################################
alias ls="ls -GF"
alias rs="bundle exec rails s"
alias rc="bundle exec rails c"
alias diff="colordiff -u"
alias less="less -q"
alias vim="nvim"


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

# tmux + fzf
fts() {
  local session
  session=$(tmux ls -F "#{session_name}" > /dev/null | fzf-tmux --reverse +m) &&
    tmux switch-client -t $session
  zle reset-prompt
}
zle -N fts

# ghq + fzf
frepo() {
  local dir
  dir=$(ghq list > /dev/null | fzf-tmux --reverse +m) &&
    builtin cd $(ghq root)/$dir
  zle reset-prompt
}
zle -N frepo


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

# search tmux session
bindkey '^J' fts


##########################################
# Others
##########################################
# tmux session attach
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
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

      tmux new-session && echo "tmux created new session"
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

  zplug "zsh-users/zsh-history-substring-search"

  zplug "zsh-users/zsh-syntax-highlighting", \
    defer:2

  zplug "zsh-users/zsh-autosuggestions"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yuki/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yuki/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yuki/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yuki/google-cloud-sdk/completion.zsh.inc'; fi

source /Users/yuki/.docker/init-zsh.sh || true # Added by Docker Desktop
