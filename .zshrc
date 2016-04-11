source ~/.bashrc
zstyle ':completion:*:*:git:*' script ~/.zsh/completion/git-completion.bash
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

export LANG=ja_JP.UTF-8
export DJANGO_SETTINGS_MODULE="mb_2.settings.development"

autoload -Uz colors
colors

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats '%K{green}[%b]%k'
zstyle ':vcs_info:*' actionformats '%K{red}[%b(%a)]%k'
precmd() { vcs_info }
PROMPT='%{${bg[blue]}%}[%~]%{${reset_color}%}
%{${bg[yellow]}%}[%n@%m]%{${reset_color}%}${vcs_info_msg_0_}'

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
