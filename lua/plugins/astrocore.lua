-- AstroCore provides a central place to modify mappings, vim options, commands, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- 

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
      notifications = false
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = false,
    },
    -- vim options can be configured here
    options = {
      opt = {
        swapfile = false,
        relativenumber = true,
        wrap = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        autochdir = true,
        confirm = false,
        scrolloff = 5,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    autocmds = {
      terminal = {
        {
          event = "TermOpen",
          pattern = { "term://*" },
          callback = function() vim.cmd('startinsert') end,
          desc = "Start terminal in insert mode",
        },
      },
      ftplugin = {
        {
          event = "FileType",
          pattern =  "markdown",
          callback = function() vim.opt.list = true end,
          desc = "setlocal for markdown",
        }, {
          event = "FileType",
          pattern =  "python",
          callback = function()
            vim.api.nvim_buf_set_keymap(0, "n", "<leader>r", ":update | below term python %<CR>", { noremap=true, silent = true, desc= 'Run Python' })
          end,
          desc = "Run code",
        }, {
          event = "FileType",
          pattern =  "javascript",
          callback = function()
            vim.api.nvim_buf_set_keymap(0, "n", "<leader>r", ":! node %<CR>", { noremap=true, silent = true, desc= 'Run JavaScript' })
          end,
          desc = "Run code",
        }, {
          event = "FileType",
          pattern =  "sh",
          callback = function()
            vim.api.nvim_buf_set_keymap(0, "n", "<leader>r", ":! bash %<CR>", { noremap=true, silent = true, desc= 'Run Shell' })
          end,
          desc = "Run code",
        }, 
        {
          event = "FileType",
          pattern =  "c",
          callback = function()
            vim.api.nvim_buf_set_keymap(0, "n", "<leader>r", ":update | ! gcc -o /tmp/a.out -lm % && /tmp/a.out<CR>", { noremap=true, silent = true, desc= 'Run C' })
          end,
          desc = "Run code",
        },
        {
          event = "FileType",
          pattern =  "cpp",
          callback = function()
            vim.api.nvim_buf_set_keymap(0, "n", "<leader>r", ":update | ! g++ -O2 % -o /tmp/a.out && /tmp/a.out<CR>", { noremap=true, silent = true, desc= 'Run C' })
          end,
          desc = "Run code",
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
        desc = "Remove trailing spaces in the entire buffer."
      },
      KeepTwoTrailingSpaces = {
        function()
          vim.api.nvim_command("%s/\\s\\+$/  /g")
        end,
        desc = "Remove trailing spaces in the entire buffer."
      },
      FixQuotes = {
        function()
          vim.api.nvim_command('normal! mz')
          pcall(vim.cmd, [[%s/[“”]/"/g]])
          pcall(vim.cmd, [[%s/[‘’]/'/g]])
          vim.api.nvim_command('normal! `z')
        end,
        desc = "Remove trailing spaces in the entire buffer."
      },
      FixMultipleSpaces = {
        function(opts)
          local start_line = opts.line1
          local end_line = opts.line2
          vim.cmd(string.format('%d,%ds/\\(\\S\\)\\s\\+/\\1 /g', start_line, end_line))
        end,
        range = true,
        desc = "Replace multiple consecutive whitespace characters with a single space."
      },
    },
    mappings = {
      n = {
        ["<Leader>c"] = {
          function()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            require("astrocore.buffer").close(0)
            if require("astrocore").is_available("alpha-nvim") and not bufs[2] then
              require("alpha").start()
            end
          end,
          desc = "Close buffer",
        },

        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous Buffer" },

        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },


        ["<Leader>ff"] = { function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.expand("~"),
            find_command = { "fd" },
            file_ignore_patterns = {
              "**/node_modules/",
              "**/build/"
            }
          })
        end,
          desc = "Find all files",
        },

        -- NOTE: Setting a mapping to false will disable it.
        ["<Leader>q"] = false,
        ["<Leader>w"] = false,
        ["<Leader>fF"] = false,
      },
      i = {
        ["<C-l>"] = { function()
          if require("luasnip").choice_active() then
            require("luasnip").change_choice(1)
          end
        end, desc = "Change snippet choice." },
      },

      s = {
        ["<C-l>"] = { function()
          if require("luasnip").choice_active() then
            require("luasnip").change_choice(1)
          end
        end, desc = "Change snippet choice." },
      },
    },
  },
}
