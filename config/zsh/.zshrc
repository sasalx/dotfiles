
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
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'

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