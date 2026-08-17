
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Path
export PATH="$HOME/.local/bin:$PATH"

# Core Plugins
zinit light zsh-users/zsh-syntax-highlighting ## Syntax highlighting
zinit light zsh-users/zsh-completions # Tab completions
zinit light Aloxaf/fzf-tab # Better tab completion menu
zinit light zsh-users/zsh-autosuggestions # Fish like autosuggestions

## Extra Completion Snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

## Initialize completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Styling

### Catppuccin Mocha palette (https://catppuccin.com/palette)
typeset -A ctp
ctp[rosewater]="#f5e0dc"
ctp[mauve]="#cba6f7"
ctp[red]="#f38ba8"
ctp[peach]="#fab387"
ctp[yellow]="#f9e2af"
ctp[green]="#a6e3a1"
ctp[teal]="#94e2d5"
ctp[sky]="#89dceb"
ctp[blue]="#89b4fa"
ctp[lavender]="#b4befe"
ctp[text]="#cdd6f4"
ctp[overlay0]="#6c7086"
ctp[surface1]="#45475a"
ctp[surface0]="#313244"
ctp[base]="#1e1e2e"
ctp[accent_red]="#db4b4b" # brighter red, used where mauve/red need a punchier accent

export FZF_DEFAULT_OPTS="\
--layout=default --border \
--color=bg+:$ctp[surface0],bg:$ctp[base],spinner:$ctp[rosewater],hl:$ctp[red] \
--color=fg:$ctp[text],header:$ctp[red],info:$ctp[mauve],pointer:$ctp[accent_red] \
--color=marker:$ctp[lavender],fg+:$ctp[text],prompt:$ctp[mauve],hl+:$ctp[red] \
--color=selected-bg:$ctp[surface1] \
--color=border:$ctp[surface0],label:$ctp[text]"

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]="fg=$ctp[text]"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=$ctp[red],bold"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=$ctp[green]"
ZSH_HIGHLIGHT_STYLES[alias]="fg=$ctp[mauve],bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=$ctp[mauve],bold"
ZSH_HIGHLIGHT_STYLES[function]="fg=$ctp[mauve],bold"
ZSH_HIGHLIGHT_STYLES[command]="fg=$ctp[mauve],bold"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=$ctp[accent_red],standout"
ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=$ctp[mauve]"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=$ctp[green]"
ZSH_HIGHLIGHT_STYLES[path]="fg=$ctp[blue],underline"
ZSH_HIGHLIGHT_STYLES[path_pathseparator]="fg=$ctp[sky]"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=$ctp[peach]"
ZSH_HIGHLIGHT_STYLES[history-expansion]="fg=$ctp[yellow]"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=$ctp[peach]"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=$ctp[peach]"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=$ctp[yellow]"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=$ctp[yellow]"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=$ctp[yellow]"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=$ctp[yellow]"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=$ctp[yellow]"
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=$ctp[yellow]"
ZSH_HIGHLIGHT_STYLES[assign]="fg=$ctp[text]"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=$ctp[green]"
ZSH_HIGHLIGHT_STYLES[comment]="fg=$ctp[overlay0],standout"
ZSH_HIGHLIGHT_STYLES[named-fd]="fg=$ctp[red]"
ZSH_HIGHLIGHT_STYLES[numeric-fd]="fg=$ctp[red]"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=$ctp[green]"

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Add colors to ls command
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # Show inside of folder when using cd
zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath' # Show inside of folder when using zoxide

# Aliases
alias clr='clear'
alias psh="sudo pacman -Ss"
alias pin="sudo pacman -S"
alias prm="sudo pacman -Rsn"
alias pcln="sudo pacman -Rsn $(pacman -Qtdq)"
alias pclnch="sudo pacman -Scc"
alias pupall="sudo pacman -Syu"
alias jctl="journalctl -p 3 -xb"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias ls='eza --color=always --group-directories-first'
alias ll='eza -la --color=always --group-directories-first --icons'
alias lt='eza --tree --color=always --group-directories-first'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)" # After fzf

# Bindkeys
bindkey -r '^[c' # unbind the default Alt+C from fzf
bindkey '^[t' fzf-cd-widget   # bind Alt+T to the fzf cd widget instead