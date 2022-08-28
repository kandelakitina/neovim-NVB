local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Colorscheme
    use {
      "projekt0n/github-nvim-theme",
      config = function()
        vim.cmd "colorscheme github_dark_default"
      end,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()                 -- This calls for a file:
        require("config.alpha").setup()   -- ./config/alpha.lua
      end,                                -- Make all plugins do this 
    }

    -- Git
    use {
      "TimUntersberger/neogit",
      cmd = "Neogit",     -- Lazy loads plugin only after Neogit cmd
      requires = "nvim-lua/plenary.nvim",  -- Requires dependency
        config = function()
          require("config.neogit").setup()
      end,
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",   -- Lazy loads upon event (Vim started)
      config = function()
        require("config.whichkey").setup()
      end,
    }
   
    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",   -- Lazy loads upon event (before editing new buffer)
      config = function()
        require("config.indentblankline").setup()
      end,
    }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", 
      module = "plenary"    -- Lazy loads only when module is called by someone
    }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      opt = true,           
      keys = { "gc", "gcc", "gbc" }, -- Lazy loads when keys are pressed
      config = function()
        require("Comment").setup {}
      end,
    }

    -- Leap
    use 'ggandor/leap.nvim'
    
    -- Lualine
    use {
      'nvim-lualine/lualine.nvim',
      event = "VimEnter",
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require("lualine").setup {
          options = {
            theme = "auto" -- or you can assign github_* themes individually.
            -- ... your lualine config
          }
        }
      end
    }

    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    }
    
    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("config.nvim-treesitter").setup()
      end,
    }

    use 'MunifTanjim/tree-sitter-lua' -- Lua parser (delete)

    -- Better Netrw
    use {"tpope/vim-vinegar"}

    -- NVim-tree
    use {
     "kyazdani42/nvim-tree.lua",
     requires = {
       "kyazdani42/nvim-web-devicons",
     },
     cmd = { "NvimTreeToggle", "NvimTreeClose" },
       config = function()
         require("config.nvimtree").setup()
       end,
    }

    -- Buffer line
    use {
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      config = function()
        require("config.bufferline").setup()
      end,
    }

    use 'andymass/vim-matchup'
    use 'chaoren/vim-wordmotion'
    use 'wellle/targets.vim' -- Adds new text objects
    use 'unblevable/quick-scope' -- Easier 'f' / 't' jumps


    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)

-- This must be in the end of the file
end

return M