-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing


---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true,
      cmp = true,
      diagnostics_mode = 3,
      highlighturl = true,
      notifications = false,
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = true,
        autochdir = true,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    autocmds = {
      terminal = { -- This is the au group
        {
          event = "TermOpen",
          desc = "Start terminal in insert mode",
          pattern = { "term://*" },
          callback = function() vim.cmd('startinsert') end,
        },
      },
    },
    commands = {
      MakeTitleCase = {
        function()
          vim.api.nvim_command("normal! i\")
          vim.api.nvim_command("s#\\v(\\w)(\\S*)#\\u\\1\\L\\2#g")
          vim.api.nvim_command("normal! kJ")
        end,
        desc = "Make the current line title case"
      },
      StripTrailingSpaces = {
        function()
          vim.api.nvim_command("%s/\\s\\+$//g")
        end,
        desc = "Make the current line title case"
      },
    },
    mappings = {
      n = {
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        ["<Leader>fp"] = { function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.expand("~/projects"),
            find_command = { "fd", "--type", "d"},
            file_ignore_patterns = {"**/node_modules/", "**/build/"}
          })
        end,
          desc = "Find projects",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menu
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
      i = {

        ["<C-h>"] = { function() 
          if require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          end
        end,
          desc = "Jump node backwards." 
        },
        ["<C-l>"] = { function() 
          if require("luasnip").jumpable(1) then
            require("luasnip").jump(1)
          end
        end,
          desc = "Jump node forwards." 
        },
        ["<C-v>"] = { function() 
          if require("luasnip").choice_active() then
            require("luasnip").change_choice(1) 
          end
        end, desc = "Change snippet choice." },
      },
    },
  },
}


