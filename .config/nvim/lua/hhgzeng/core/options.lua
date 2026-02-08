vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- 行号
opt.number = true
opt.relativenumber = true

-- 缩进
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- 防止包裹
opt.wrap = false

-- 光标
-- 1. 优化 guicursor 字符串, 为关键模式关联不同的高亮组
vim.opt.guicursor = table.concat({
  -- 普通/可视/命令行模式: 块状, 关联 "Cursor" 高亮组
  "n-v-c:block-Cursor",
  -- 插入模式: 竖线, 关联 "iCursor" 高亮组 (这是关键区别)
  "i-ci-ve:ver25-iCursor",
  -- 替换模式: 横线, 关联 "rCursor" 高亮组
  "r-cr:hor20-rCursor",
  -- 其他模式沿用你的设置, 但颜色也统一使用普通模式的 "Cursor" 组
  "o:hor50-Cursor",
  "sm:block-Cursor",
  -- 对所有模式通用: 关闭光标闪烁
  "a:blinkwait0-blinkoff0-blinkon0",
}, ",")

-- 2. 分别为这些高亮组定义颜色
-- 使用 autocmd 防止被颜色主题覆盖
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- 为 "Cursor" (普通模式等) 设置为紫色
    vim.api.nvim_set_hl(0, "Cursor", { bg = "#cba6f7" })
    
    -- 为 "iCursor" (插入模式) 设置为红色, 以明确区分
    vim.api.nvim_set_hl(0, "iCursor", { bg = "#f38ba8" })
    
    -- 为 "rCursor" (替换模式) 设置为蓝色
    vim.api.nvim_set_hl(0, "rCursor", { bg = "#74c7ec" })
  end,
})
-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   command = "silent! !echo -ne '\\e[5 q'"
-- })
-- opt.guicursor = "a:ver25"
-- opt.mouse:append("a")

-- 系统剪切板
opt.clipboard:append("unnamedplus")

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 退格键
opt.backspace = "indent,eol,start"

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"
opt.background = "dark"