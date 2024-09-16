##################################################
### editor setup


PROMPT='%n@%m:%~ %# '
zstyle ':completion:*' menu select
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export EDITOR=vim


##################################################
### plugin


source ~/.zplug/init.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"


##################################################
### alias

alias "dup"="docker-compose up -d $1"
alias "dexe"="docker-compose exec $1 $2"
alias "dexer"="docker-compose exec --user root $1 $2"
alias "ddown"="docker-compose down"


##################################################
### key bind


typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete


##################################################
### option


## 色を使う
setopt prompt_subst

## 開始と終了を記録
setopt EXTENDED_HISTORY

## 同時起動中のzsh間でhistoryを共有
setopt share_history

## 直前と同じコマンドをhistroyに追加しない
setopt hist_ignore_dups

## TAB で順に補完候補を切り替える
setopt auto_menu

## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history

## 同じコマンドをhistoryに追加しない
setopt hist_ignore_all_dups

# スペースで始まるコマンド行はhistoryから削除
setopt hist_ignore_space

## histroyを呼び出してから実行する間に一旦編集
setopt hist_verify

## 古いコマンドと同じものは無視
setopt hist_save_no_dups

## ワイルドカード展開
setopt extended_glob

## historyに追加する際、スペースを削除
setopt hist_reduce_blanks

## スペルミスを指摘
setopt correct

## 補完候補を一覧表示
setopt auto_list

## 補完候補の色づけ
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## ディレクトリ名だけで ディレクトリ移動
setopt auto_cd

# source plugin
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose
