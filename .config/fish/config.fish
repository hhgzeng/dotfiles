# ---------- Homebrew 核心路径 ----------
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

# ---------- 🌐 环境变量 ----------
# 'set -g' (global) 'set -x' (export) -> 'set -gx'
set -gx EDITOR nvim
set -gx HOMEBREW_NO_AUTO_UPDATE 1

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
  eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
else
  if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
    . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
  else
    set -x PATH "/opt/homebrew/Caskroom/miniconda/base/bin" $PATH
  end
end
# <<< conda initialize <<<

# ---------- 🚀 Shell 工具初始化 ----------
eval "$(starship init fish)"
eval "$(zoxide init fish)"
eval "$(fzf --fish)"

direnv hook fish | source
fnm env --use-on-cd | source

# ---------- 💡 别名 ----------
alias cls="clear"
alias quit="exit"
alias cd="z"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias cat="bat"
alias ff="fastfetch"

# ---------- 其他 ----------
# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# OpenClaw Completion
source "/Users/jingzeng/.openclaw/completions/openclaw.fish"

# bun
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH
