return {
  "hrsh7th/nvim-cmp",
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require("cmp")
    opts.completion = { completeopt = 'menu,menuone,noinsert'}

    -- modify the mapping part of the table
    opts.mapping["<C-e>"] = cmp.mapping.abort()
    opts.mapping["<C-b>"] = cmp.mapping.scroll_docs(-4)
    opts.mapping["<C-f>"] = cmp.mapping.scroll_docs(4)

    opts.window.completion = cmp.config.window.bordered({
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
      winhighlight = 'Normal:Normal,FloatBorder:Comment,CursorLine:Visual,Search:None',
      scrollbar = false
    })

    opts.window.documentation = cmp.config.window.bordered({
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
      winhighlight = 'Normal:Normal,FloatBorder:Comment,CursorLine:Visual,Search:None',
    })



  end,
}

