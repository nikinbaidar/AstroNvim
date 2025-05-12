local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local extras = require("luasnip.extras")
local l = extras.lambda -- https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua#L373
local rep = extras.rep
local m = extras.match
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta -- https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua#L287
local conds = require("luasnip.extras.expand_conditions")
local parse = require("luasnip.util.parser").parse_snippet


local lorem = [[ Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ]]

-- HACK: RECURRING FUNCTIONS. MAYBE IMPLEMENT `rep` later.

local rec_etymology

function rec_etymology()
  return sn( nil, c(1, {
    t({""}),
    sn(nil, {
      t({"", ""}),
      i(1, "root/affix"), t(" & "),
      i(2, "meaning"),t (" & "),
      i(3, "example"), t({" \\\\"}),
      d(4, rec_etymology, {}),
    }),
  }))
end


local function color(index)
  return d(index, function()
    return sn(nil, c(1, {
      sn(1, {t"#", i(1)}),
      i(1, "color-name"),
      sn(1, {t"rgb(", i(1, ""), t")"}),
    }))
  end, {})
end

local function direction(index)
  return d(index, function()
    return sn(nil, c(1, {
      i(1, "all"),
      sn(1, {i(1, "top-bottom"), t(" "), i(2, "left-right") }),
      sn(1, {i(1, "top"), t(" "), i(2, "left-right"), t(" "), i(3, "bottom") }),
      sn(1, {i(1, "top"), t(" "), i(2, "right"), t(" "), i(3, "bottom"), t(" "), i(4, "left") }),
    }))
  end, {})
end

local function nthselector(index)
  return d(index, function(args)
    local second_choice = args[1][1]
    if second_choice:sub(1,1) == "n" then
      return sn(nil, {t"(", i(1), t(")")})
    end
    return sn(nil, {t""})
  end, {1})
end


ls.add_snippets("all", {
  parse({ trig = "hw", snippetType = "autosnippet" }, "Hello, World!"),
  parse({ trig = "lorem", snippetType = "autosnippet" }, lorem ),
  parse({ trig = "/sig", snippetType = "autosnippet" }, "Nikin Baidar" ),
  parse({ trig = "/email", snippetType = "autosnippet" }, "nikinbaidarr@gmail.com" ),
  parse("~", "/home/nikin" ),

	s("mat2", {
		i(1, { "sample_text" }),
		t(": "),
		m(1, "border-", "not-shorthand", "shorthand"),
	}),

	s("mat", {
		i(1, { "sample_text" }),
		t(": "),
		m(1, function(args)
		  return (args[1][1] == "border-" and "hi" or args[1][1])
		end),
	}),

  s("date", {
    c(1, {
  	  t(os.date('%Y-%m-%d')),
  	  t(os.date('%Y-%m-%d %H:%M:%S')),
    })
  }),

  s("same", fmta("example: <> reproduced-here: <>", { i(1), rep(1) })),

})

ls.add_snippets("css", {

  s("color", fmt("color: {};", { color(1) })),

  s("bg", fmt("background: {};", { i(1) })),
  s("bgc", fmt("background-color: {};", { color(1) })),

  s({trig="bd", desc="border"}, fmt("border{}: {};", {
    c(1, {t(""), t("-style"), t("-width")}),
    i(2, "1px solid black")
  })),

  s({trig="p", desc="padding"}, fmt("padding{}: {};", {
    c(1, {t(""), t("-left"), t("-right"), t("-top"), t("-bottom")}),
    direction(2)
  } )),

  s({trig="m", desc="margin"}, fmt("margin{}: {};", {
    c(1, {t(""), t("-left"), t("-right"), t("-top"), t("-bottom")}),
    direction(2)
  })),

	-- s( { trig = "[%.%#]%a+", regTrig = true, desc = "Selectors" },  {
	-- 	f(function(_, snip) return snip.trigger .. " " end, {}),
	-- 	t({"{", "\t"}),
	-- 	i(1),
	-- 	t({"", "}"}),
	-- }),

	s( { trig = "[%.%#]", regTrig = true, desc = "div" },  {
		c(3,{ t(""), i(1, "elem"), t("div")}),
		f(function(_, snip) return snip.trigger end, {}),
		i(1), t({" {", "\t"}), i(2), t({"", "}"}),
	}),

	s( { trig = "h", desc = "height" },  { t("height : "), i(1), t(";") }),

	s( { trig = "w", desc = "width" },  { t("width : "), i(1), t(";") }),

	s( { trig = ":a", desc = "" },  { t("width : "), i(1), t(";") }),

	s({ trig = ":child", des = "Selectors"}, fmt("{}:{}-child{}", {
	  i(2, "elem"),
    c(1, { t("first"), t("last"), t("nth"), t("nth-last"), t("only") }),
    nthselector(3)
	}))


})


ls.add_snippets("html", {
  s({trig ="h(%d)", regTrig = true},
    fmt("<h{}>{}</h{}>", {
      f(function(_, snip) return snip.captures[1] end),
      i(1),
      f(function(_, snip) return snip.captures[1] end),
    })),
})

ls.add_snippets("tex", {
  parse("ohm", "$\\Omega$"),
  parse("jw", "$j\\omega$"),

  parse("hyper", [[
    \usepackage{hyperref}

    \hypersetup{
        colorlinks=true,
        linkcolor=black,
        filecolor=magenta,
        urlcolor=blue,
    }

    \newcommand{\hrefund}[2]{\href{#1}{\underline{#2}}}
    ]]),

  s("slide", fmta([[
      \begin{frame}
          \frametitle{<>}
          \subsection{<>}
          <>
          \vfill
      \end{frame}
      ]], { i(1), rep(1), i(2)})
  ),

  s("tc", fmta("\textcolor{magenta}{<>}", {i(1)})),

  parse({
    trig = "baselineskip",
    snippetType = "autosnippet",
  }, [[\enlargethispage{\baselineskip}]]
  ),


  s("up", {
    t("\\usepackage"),
    c(1, {
      sn(nil, {t("{"), i(1), t("}")}),
      sn(nil, {t("["), i(1), t("]"), t("{"), i(2), t("}")}),
    }), }
  ),

  s({ trig = "\\q" }, {
    t({"\\question", ""}),
    i(1),
    t({"", "\\begin{choices}"}),
    t({"", "    \\choice "}), i(2),
    t({"", "    \\choice "}), i(3),
    t({"", "    \\choice "}), i(4),
    t({"", "    \\choice "}), i(5),
    t({"", "\\end{choices}", ""}),
  }
  ),

  s({ trig = "\\m" }, {
      t("\\["), i(1), t("\\]")
    }),


  s("fig", fmta([[
      \begin{figure}
          \centering
          \includegraphics[scale=<>]{"<>"}
          \caption{<>}
          \label{fig:<>}
      \end{figure}

      ]], { i(1), i(2), i(3), rep(2)})
  ),

  s("word", {
    i(1, "ROOT/AFFIX"), t(" & "),
    i(2, "MEANING"),t (" & "),
    i(3), t({" \\\\"}),
    d(4, rec_etymology, {}),
  }),

  s( {trig = "(.*)fn", regTrig = true},
    fmt("{}\\footnote{{{}}}", {
      f(function(_, snip) return snip.captures[1] end, {}),
      i(1),
    })),

  s( {trig = "frac"},
    fmt("\\displaystyle\\frac{{{}}}{{{}}}", {
      i(1), i(2)
    })),

  s("doc", fmta([[
      \documentclass{<>}

      \usepackage[margin=1in]{geometry}

      \begin{document}

      <>

      \end{document}
      ]], { i(1), i(2) })
  ),


  s("dcl", fmta([[\documentclass[12pt<>]{<>}]], {
    i(2), i(1)
  })),

  s("beg", fmta([[
  \begin{<>}
    <>
  \end{<>}
  ]], {i(1), i(2), rep(1)})),

  s("eq", fmta([[
  \begin{equation}
    <>
  \end{equation}
  ]], {i(1)})),


  -- MATHEMATICS

  s("cases", fmt([[
      \begin{{cases}}
          {} & \text{{if }} {}
          {} & \text{{if }} {}
      \end{{cases}}
      ]], {
      i(1, "exp1"), i(2, "cond1"), i(3, "exp2"), i(4, "cond2")
    })),
})

ls.add_snippets("python", {

  s("class", fmta([[
  class <>(<>):
    <>
  ]], { i(1), i(2), i(3, "pass")  })),

  s("init", fmta([[
  def __init__(self, <>):
      <>
  ]], { i(1), i(2, "pass")})),

  s("def", fmta([[
  def <>(<>):
      <>
  ]], { i(1), i(2), i(3, "pass")})),

	s( { trig = "with([%a]?[%a+]?)", regTrig = true, desc = "div" }, fmta([[
  with open(<>, "<>") as f:
      <>
	]],  {
		i(1, "file"),
    f(function(_, snip) return snip.captures[1] end),
		i(2, "pass"),
	})),

	s({ trig = "ifmain", desc="if main"}, fmta([[
  if __name__ == "__main__":
      main()
	]],  {})),

	s({ trig = "cv2_imshow", desc=""}, fmta([[
  def scale_img(im, scale=1.0):
      if not isinstance(im, np.ndarray):
          raise TypeError(f"Expected numpy.ndarray got {type(im)}")

      height, width = im.shape[:2]
      new_width = int(width * scale)
      new_height = int(height * scale)
      im = cv2.resize(im, (new_width, new_height))
      return im


  def cv2_imshow(im, scale=None):
      if not isinstance(im, np.ndarray):
          raise TypeError(f"Expected numpy.ndarray got {type(im)}")

      if scale is not None:
          im = scale_img(im, scale=scale)

      cv2.imshow("", im)
      while True:
          if cv2.waitKey() == 27:
              cv2.destroyAllWindows()
              break
	]],  {})),


})
