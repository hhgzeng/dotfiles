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

# ===================================================================
# ⚙️ Oh My Zsh (OMZ) 核心配置
# ===================================================================
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

# ===================================================================
# 🎨 主题配置 (Starship & P10k)
# ===================================================================
# Starship
eval "$(starship init zsh)"

# Powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ===================================================================
# 🌐 系统环境变量配置
# ===================================================================
# 默认编辑器
export EDITOR=nvim

# ===================================================================
# 📦 包与版本管理器
# ===================================================================

# -------------------------------------------------------------------
# Homebrew
# -------------------------------------------------------------------
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE=1

# -------------------------------------------------------------------
# Node (nvm)
# -------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# -------------------------------------------------------------------
# Conda
# -------------------------------------------------------------------
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/opt/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="/opt/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# # <<< conda initialize <<<

# ===================================================================
# 🔧 实用工具 & 别名
# ===================================================================

# -------------------------------------------------------------------
# 常用别名 (Aliases)
# -------------------------------------------------------------------
# 现代工具替代
alias cat="bat"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias cd='z' # zoxide 替代 cd

# 快捷命令
alias ft='exiftool'
alias ff='fastfetch'
alias cls='clear'
alias quit='exit'

# -------------------------------------------------------------------
# fzf (模糊查找) & fd (查找文件)
# -------------------------------------------------------------------
# 使用 fd 替代 fzf 的默认命令
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# fzf 预览配置
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# fzf 补全函数
# Use fd (https://github.com/sharkdp/fd) for listing path candidates. 
_fzf_compgen_path() { 
  fd --hidden --exclude .git . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;; 
  esac 
}

# -------------------------------------------------------------------
# 其他工具
# -------------------------------------------------------------------
# fzf-git (fzf 的 git 集成)
source ~/fzf-git.sh/fzf-git.sh

# ===================================================================
# 🔌 第三方工具 & 初始化
# ===================================================================

# -------------------------------------------------------------------
# 工具初始化 (必须放在较后位置)
# -------------------------------------------------------------------
# fzf: 命令行模糊查找工具
eval "$(fzf --zsh)"

# zoxide: 现代化的 cd 命令替代品
eval "$(zoxide init zsh)"
