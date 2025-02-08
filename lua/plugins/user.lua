-- NOTE: You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

function Projects()
  require("telescope.builtin").find_files({
    cwd = vim.fn.expand("~/projects"),
    find_command = { "fd", "--type", "d"},
    file_ignore_patterns = {
      "**/node_modules/",
      "**/build/"
    }
  })
end

function FindAll()
  require("telescope.builtin").find_files({
    cwd = vim.fn.expand("~"),
    find_command = { "fd" },
    file_ignore_patterns = {
      "**/node_modules/",
      "**/build/"
    }
  })
end

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  { "tpope/vim-surround"},
  { "tpope/vim-repeat"},
  { 'kristijanhusak/vim-dadbod-ui',
    dependencies = { "nikinbaidar/vim-dadbod" }},
  -- == Examples of Overriding Plugins ==

  
  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled=false },
  { "rafamadriz/friendly-snippets", enabled=false },
  { "andweeb/presence.nvim", enabled=false},
  { "goolord/alpha-nvim", enabled=false},


  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      local extensions = {
        javascript = { "html", "react" },
        plaintex = { "tex" },
      }

      for ft, ext in pairs(extensions) do
        luasnip.filetype_extend(ft, ext)
      end

      luasnip.config.setup({
        enable_autosnippets = true
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup({
        -- Customize your settings here
        signs = true, -- Show icons in the signs column
        keywords = {
          FIX = { icon = " ", color = "error", },
          DONT = { icon = "✗", color = "error", alt = { "DO NOT", "REMEMBER" } },
          TODO = { icon = " ", color = "info", alt = {} },
          INSTEAD = { icon = " ", color = "hint", alt = {"INSTEAD"} },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
          PERF = { icon = " ", color = "#8B5DFF", alt = { "INFO", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "DO", } },
          IDEA = { icon = " ", color = "hint", alt = { "SUGGESTION", "CONCEPT" }, },
        },
        highlight = {
          before = "", -- Highlight before the keyword
          keyword = "wide", -- Highlight the keyword itself
          after = "fg", -- Highlight text after the keyword
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
