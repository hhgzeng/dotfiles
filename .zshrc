# ===================================================================
# 🚀 启动优化 (P10k Instant Prompt)
# ===================================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block;
# everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ⚙️ Oh My Zsh 核心配置
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# OMZ Theme
# ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME="" # 使用 Starship 时，禁用 OMZ 默认主题

# OMZ auto-update
zstyle ':omz:update' mode auto

# Disable auto-setting terminal title
DISABLE_AUTO_TITLE="true"

# OMZ Plugins
# Standard plugins can be found in $ZSH/plugins/
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

# 加载 Oh My Zsh
source $ZSH/oh-my-zsh.sh

# 🎨 主题配置 (Starship & P10k)
# Starship
eval "$(starship init zsh)"

# Powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 🌐 系统环境变量配置
export EDITOR=nvim
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE=1

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/opt/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
  else
    export PATH="/opt/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# # <<< conda initialize <<<

# ---------- 💡 别名 ----------
alias cat="bat"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias cd='z'
alias ff='fastfetch'
alias cls='clear'
alias quit='exit'

# ---------- 🚀 Shell 工具初始化 ----------
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# ---------- 其他 ----------
