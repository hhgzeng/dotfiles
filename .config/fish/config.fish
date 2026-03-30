# ===================================================================
#
#               🐟 Fish Shell 配置文件 (config.fish)
#
# ===================================================================

# -------------------------------------------------------------------
# 📦 包管理器与核心路径 (PATH)
# -------------------------------------------------------------------
# Fish 推荐使用 fish_add_path，它会避免重复添加。

# Homebrew 核心路径
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

# -------------------------------------------------------------------
# 🌐 环境变量 (Environment Variables)
# -------------------------------------------------------------------
# 'set -g' (global) 'set -x' (export) -> 'set -gx'

# 默认编辑器
set -gx EDITOR nvim

# 禁用 Homebrew 自动更新
set -gx HOMEBREW_NO_AUTO_UPDATE 1

# -------------------------------------------------------------------
# Conda
# -------------------------------------------------------------------
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

# -------------------------------------------------------------------
# 🚀 Shell 工具初始化
# -------------------------------------------------------------------

# Starship: 跨平台提示符
eval "$(starship init fish)"

# fzf: 命令行模糊查找工具
eval "$(fzf --fish)"

# zoxide: 现代化的 cd 命令替代品
eval "$(zoxide init fish)"

# -------------------------------------------------------------------
# 🔍 fzf 详细配置
# -------------------------------------------------------------------
# (此部分已合并并去除了原 config.fish 中的重复内容)

# -- 使用 fd 替代 fzf 默认的 'find' --
set -gx FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# -- fzf 预览设置 --
# 定义一个变量来存储预览命令
set -gx show_file_or_dir_preview "if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# 将预览命令应用到 fzf
set -gx FZF_CTRL_T_OPTS "--preview '$show_file_or_dir_preview'"
set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"
# -- fzf 补全函数 (Fish 语法) --

# 使用 fd (https://github.com/sharkdp/fd) 列出路径候选项。
function _fzf_compgen_path
  fd --hidden --exclude .git . $argv[1]
end

# 使用 fd 生成目录补全列表
function _fzf_compgen_dir
  fd --type=d --hidden --exclude .git . $argv[1]
end

# 高级定制：根据命令（如 cd, ssh）提供不同预览
function _fzf_comprun
  set -l command $argv[1]
  set -e argv[1]

  switch $command
    case cd
      fzf --preview 'eza --tree --color=always {} | head -200' $argv
    case export unset
      # Fish 中 'export' 和 'unset' 不常用，但保留
      fzf --preview "eval 'echo {}'" $argv
    case ssh
      fzf --preview 'dig {}' $argv
    case '*'
      fzf --preview "$show_file_or_dir_preview" $argv
  end
end


# -------------------------------------------------------------------
# 💡 别名 (Aliases)
# -------------------------------------------------------------------

# 基本命令
alias cls="clear"
alias quit="exit"

# 导航
alias cd="z"

# 查看
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias cat="bat"

# 工具
alias ff="fastfetch"

direnv hook fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Added by Antigravity
fish_add_path /Users/jingzeng/.antigravity/antigravity/bin

# OpenClaw Completion
source "/Users/jingzeng/.openclaw/completions/openclaw.fish"
