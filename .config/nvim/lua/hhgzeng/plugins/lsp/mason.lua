return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim", -- LSP服务器管理
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- 工具自动安装
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- Mason基础设置
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
        border = "rounded", -- 添加边框样式
      },
      max_concurrent_installers = 4, -- 并发安装数
    })

    -- LSP服务器安装配置
    mason_lspconfig.setup({
      ensure_installed = {
        "ts_ls", -- TypeScript/JavaScript
        "html", -- HTML
        "cssls", -- CSS
        "tailwindcss", -- Tailwind CSS
        "svelte", -- Svelte
        "lua_ls", -- Lua
        "graphql", -- GraphQL
        "emmet_ls", -- Emmet
        "prismals", -- Prisma
        "pyright", -- Python
        "clangd", -- C/C++
      },
      automatic_installation = true, -- 自动安装缺失的LSP
    })

    -- 开发工具安装配置
    mason_tool_installer.setup({
      ensure_installed = {
        -- 格式化工具
        "prettier", -- 通用格式化
        "stylua", -- Lua格式化
        "isort", -- Python导入排序
        "black", -- Python格式化
        
        -- 语法检查
        "pylint", -- Python检查
        "eslint_d", -- JavaScript/TypeScript检查
        "shellcheck", -- Shell脚本检查（建议添加）
        
        -- 其他工具
        "debugpy", -- Python调试（建议添加）
        "marksman", -- Markdown LSP（建议添加）
      },
      auto_update = false, -- 禁用自动更新
      run_on_start = true, -- 启动时检查安装
    })
  end,
}