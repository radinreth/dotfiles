# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Apple Silicon Homebrew lives in /opt/homebrew; Intel's /usr/local is on PATH already.
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git bundler osx rake ruby git-open)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ddevs="cd /Users/radinreth/Documents/devs"
alias web="open -a \"Google Chrome\" http://localhost:3000"
alias python="/Library/Frameworks/Python.framework/Versions/3.11/bin/python3 -m IPython"
alias nd="npm run dev"
# export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_HOME=/Users/radinreth/Library/Android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

export PATH="$PATH:$HOME/.rvm/bin:$HOME/.composer/vendor/bin" # Add RVM to PATH for scripting
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
# Removed: conflicts with asdf node management
# export PATH="/usr/local/opt/node@10/bin:$PATH"
# export PATH="/usr/local/bin/node:$PATH"
[[ -f ~/.bash_profile ]] && source ~/.bash_profile

# Old asdf (commented out for v0.18.0 upgrade)
# . /usr/local/opt/asdf/libexec/asdf.sh

# asdf v0.18.0 (Go binary)
# export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
# mise where installed (reads the same .tool-versions files), asdf otherwise
if command -v mise >/dev/null; then
  eval "$(mise activate zsh)"
else
  export ASDF_DATA_DIR="$HOME/.asdf"
  export PATH="$ASDF_DATA_DIR/shims:$PATH"
fi

export PATH="/usr/local/opt/openssl@3/bin:$PATH"
# export PATH="/usr/local/opt/openssl@3/bin:$PATH"

[[ $(uname -m) == x86_64 ]] && export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export PATH="/usr/local/sbin:$PATH"
alias nvim="~/nvim-macos-x86_64/bin/nvim $1"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# customize yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export PATH="/usr/local/opt/llvm@12/bin:$PATH"
export LIBRARY_PATH="/usr/local/opt/llvm@12/bin:$LIBRARY_PATH"
export LDFLAGS="-L/usr/local/opt/llvm@12/lib"
export CPPFLAGS="-I/usr/local/opt/llvm@12/include"
export CPATH="/usr/local/opt/llvm/include:$CPATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# override default FZF command
FZF_DEFAULT_COMMAND='fd --type f'
FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top --walker-skip Library,.git,node_modules'

. "$HOME/.local/bin/env"

# tmux aliases
alias tl="tmux ls"
alias tn="tmux new-session -s"
alias tk="tmux kill-session -t"
alias ta="tmux attach-session -t"

# reload current directory path
alias ff='cd .. && cd -'

# auto run shell inside dir
# eval "$(direnv hook zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Default Claude account for anything that spawns `claude` without going through
# the aliases below -- notably bmad-loop, which execvp's `claude` directly (aliases
# never apply) and runs it under tmux. NOTE: a tmux session inherits the tmux
# SERVER's env, so an already-running server predating this export still won't see
# it; fix that one without restarting the server via:
#   tmux setenv -g CLAUDE_CONFIG_DIR "$HOME/.claude-tsc"
export CLAUDE_CONFIG_DIR="$HOME/.claude-tsc"

# Both aliases set the var inline, so they keep overriding the export above.
alias cc="CLAUDE_CONFIG_DIR=$HOME/.claude claude"
alias ccw="CLAUDE_CONFIG_DIR=$HOME/.claude-tsc claude"

# Safely eject the external SSD (stops adb/gradle/metro first). Arg = volume name.
alias ejectssd="$HOME/bin/eject-ssd"

# --- ESB local dev (interactive shells only) ---
# Environment lives in ~/.zshenv so non-interactive shells and IDE run configs get it
# too. These two lines must stay HERE, after line 111's `source ~/.bash_profile`,
# which sets JAVA_HOME to JDK 26: re-assert the ESB JDK (otherwise Maven builds run
# on 26 and Lombok 1.18.42 fails), then put it first on PATH. ESB_JDK is defined
# once, in ~/.zshenv.
export JAVA_HOME="$ESB_JDK"
export PATH="$JAVA_HOME/bin:$PATH"
alias esb-infra='docker compose -f $HOME/Documents/devs/workspaces/tsc-org/esb/generic-template/infrastructure/development-tool/Docker/docker-compose.yml -f $HOME/.esb-local/compose-override.yml'
alias esb="$HOME/.esb-local/esb"     # esb up --with-portals | down | status | logs | restart | build
# ---

# OpenClaw Completion
source "/Users/radinreth/.openclaw/completions/openclaw.zsh"
export ANDROID_HOME=~/Library/Android/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
source ~/.kb_alias

# --- eza (modern ls replacement) ---
# Installed 2026-08-20 with `cargo install eza --version 0.23.4 --locked`, then
# symlinked ~/bin/eza -> ~/.cargo/bin/eza (~/bin is already on PATH).
# NOT via Homebrew: macOS 12 gets no bottles, so `brew install eza` compiles the
# whole dep tree (ghc, llvm@22, pandoc) from source; eza also ships no macOS
# release binaries. 0.23.4 is pinned because 0.23.5+ needs Rust 1.90 and the
# Homebrew rust here is 1.87 -- upgrade rust and eza together, or neither.
# The real ls is still reachable as `\ls` or `command ls`.
#
# Two different git columns, both on `ll`:
#   --git       per-file status inside the repo you are standing in
#               (-- clean, -N new, -M modified, -I ignored)
#   --git-repos branch name + dirty marker for any CHILD dir that is its own
#               repo (+ dirty, | clean). This is the one that matters in the
#               esb workspaces, where every service dir is a separate repo on a
#               possibly different trunk. Costs ~70ms across 13 repos.
#
# `ll`'s Date Modified is each entry's OWN mtime, so a DIRECTORY row only moves
# when an entry is added/renamed/deleted in it -- editing a file deep inside
# leaves it untouched, and a service dir can read a day stale while its src/
# changed minutes ago. Real `ls -l` does the same; this is POSIX, not an eza
# quirk. `lm` (defined below) answers the question that staleness usually means
# you were asking: newest file INSIDE each child dir, newest first.
alias ls="eza --group-directories-first"
alias ll="eza -lah --git --git-repos --group-directories-first"
alias lr="eza -lD --git-repos"                 # repo overview: which branch is each subrepo on
alias lt="eza --tree --level=2 --group-directories-first"
alias ltg="eza --tree --level=3 --git-ignore --group-directories-first"
# oh-my-zsh's l / la / lsa are defined as `ls -...`, so they chain through the
# alias above and pick up eza automatically.

# The `ll` companion described above: per child dir, the newest file inside it,
# newest first. Prunes .git/target/node_modules/.nuxt so it stays quick on the
# esb workspaces. Takes an optional dir: `lm ~/Documents/devs/workspaces`.
lm() {
  local d
  for d in ${1:-.}/*(/N); do
    find "$d" \( -name .git -o -name target -o -name node_modules -o -name .nuxt \) -prune \
      -o -type f -print0 2>/dev/null \
      | xargs -0 stat -f '%Sm %N' -t '%Y-%m-%d %H:%M' 2>/dev/null \
      | sort -r | head -1
  done | sort -r
}
# ---

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

