local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local sp = ls.parser.parse_snippet
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local rep = require("luasnip.extras").rep
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

vim.keymap.set({ "i", "n" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "n" }, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

vim.keymap.set('i', "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

ls.add_snippets("java", {
    s("jdoc",
        fmt(
            [[/** <b> {} </b> 
 * <p>
 * {}
 * </p>
 **/]]       , { i(1, "funcName"), i(0, "Docs") })),

    s("jdocr", fmt([[/**
 * <b> {} </b> 
 * <p>
 * {}
 * </p>
 *
 * @return <b> {} </b> {}
 **/]], { i(1, "funcName"), i(2, "type"), i(3, "docs"), i(0, "Docs") })),

    s("jdocp",
        fmt(
            [[/**
 * <b> {} </b> 
 * <p>
 * {}
 * </p>
 *
 * @parma <b> {} </b> {}
 **/]]       , { i(1, "funcName"), i(2, "type"), i(3, "docs"), i(0, "Docs") })),

    sp("docp", "@parma $1"),
    sp("docr", "@return $1"),
    sp("docb", "<b> $1 </b> $2"),
    sp("docpar", "<p> $1 </p>$2"),
})
