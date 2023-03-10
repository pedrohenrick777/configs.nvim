local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

local status, packer = pcall(require, 'packer')
if not status then
    return
end

return packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'

    --theme
    use { "catppuccin/nvim", as = "catppuccin" }

    -- utilities
    use 'christoomey/vim-tmux-navigator'
    use 'szw/vim-maximizer'
    use 'numToStr/Comment.nvim'

    -- icons
    use 'DaikyXendo/nvim-material-icon'
    use 'nvim-tree/nvim-web-devicons'

    -- tree
    use 'nvim-tree/nvim-tree.lua'

    -- dashboard
    use {'glepnir/dashboard-nvim'}

    -- status line
    use 'nvim-lualine/lualine.nvim'

    -- bufferline
    use 'akinsho/bufferline.nvim'

    -- fuzy finding
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }

    -- autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'

    -- snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    -- managing and installing lsp servers
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- confguring lsp servers
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use { 'glepnir/lspsaga.nvim', branch = 'main' }
    use 'onsails/lspkind.nvim'

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
    }

    -- auto closing
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'

    -- git
    use 'lewis6991/gitsigns.nvim'

    -- discord presence
    use 'andweeb/presence.nvim'

    -- colorizer
    use 'norcalli/nvim-colorizer.lua'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
