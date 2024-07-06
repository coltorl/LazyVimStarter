return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            setup = {
                rust_analyzer = function()
                    return true
                end,
            },
            inlay_hints = { enabled = false },
            servers = {
                clangd = {
                    keys = {
                        { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                    },
                    root_dir = function(fname)
                        return require("lspconfig.util").root_pattern(
                            "Makefile",
                            "configure.ac",
                            "configure.in",
                            "config.h.in",
                            "meson.build",
                            "meson_options.txt",
                            "build.ninja",
                            ".clang-format"
                        )(fname) or require("lspconfig.util").root_pattern(
                            "compile_commands.json",
                            "compile_flags.txt"
                        )(fname) or require("lspconfig.util").find_git_ancestor(fname)
                    end,
                    cmd = {
                        "clangd",
                        "--all-scopes-completion",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--fallback-style=llvm",
                        "--function-arg-placeholders=false",
                    },
                    init_options = {
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },
            },
        },
    },
    {
        "jinh0/eyeliner.nvim",
        config = function()
            require("eyeliner").setup({
                highlight_on_key = true,
            })
        end,
    },
    {
        "mfussenegger/nvim-dap",
        optional = true,
        opts = function()
            require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "c", "cpp", "rust" } })
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
    },
    {
        "lervag/vimtex",
    },
    {
        "iamcco/markdown-preview.nvim",
        config = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
                "html",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "vim",
                "yaml",
                "rust",
                "c",
                "cpp",
                "xml",
                "latex",
                "glsl",
                "http",
            },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                -- lsp
                "clangd",
                "json-lsp",
                "lua-language-server",
                "neocmakelsp",
                "pyright",
                "ruff-lsp",
                "lemminx",
                "codelldb",
                "debugpy",
                -- linter
                "cmakelang",
                "flake8", -- does ruff-lsp replace?
                "shellcheck",
                -- formatter
                "xmlformatter",
                "clang-format",
                "cmakelang",
                "stylua",
                "shfmt",
            },
        },
    },
}
