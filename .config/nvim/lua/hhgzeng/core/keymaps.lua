vim.g.mapleader = " "

local keymap = vim.keymap

-- ------------------ 插入模式 ------------------
keymap.set("i", "jk", "<Esc>", { desc = "exit insert mode with jk" })

-- ------------------ 视觉模式 ------------------
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ------------------ 正常模式 ------------------
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" }) -- 水平分割
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "split window horizontally" }) -- 垂直分割
keymap.set("n", "<leader>se", "<C-w>=", { desc = "equalize window sizes" }) -- 等分窗口
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "close current split" }) -- 关闭窗口

-- 标签页
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- 打开新标签页
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- 关闭当前标签页
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) -- 切换到下一个标签页
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) -- 切换到上一个标签页
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) -- 将当前缓冲区移动到新标签页

-- 增加/减少数字
keymap.set("n", "<leader>+", "<C-a>", { desc = "increment numbers" }) -- 增加数字
keymap.set("n", "<leader>-", "<C-x>", { desc = "decrement numbers" }) -- 减少数字

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "clear search highlights" })

-- ------------------ 代码运行 ------------------
-- Python 运行
keymap.set("n", "<leader>rp", ":!python3 %<CR>", { desc = "Run Python file" }) -- 运行当前Python文件

-- C++ 运行
keymap.set("n", "<leader>rc", ":!g++ -std=c++23 -o %:r % && ./%:r<CR>", { desc = "Compile and run C++23 file" }) -- 使用C++23标准编译并运行
