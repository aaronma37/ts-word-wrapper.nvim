-- =================
-- Requirements
-- =================
-- all functions, which can modify the buffer, like adding the semicolons and
-- commas
-- local setter = require("tree-setter/setter")
local ts_utils = require("nvim-treesitter.ts_utils")

-- =====================
-- Global variables
-- =====================
local M = {}

function get_qualified_node_under_cursor()
    local node = ts_utils.get_node_at_cursor()
    if (node == nil) then
      return nil
    end
    local max_distance = 5
    while ((node:type() ~= "qualified_identifier" and node:type() ~= "primitive_type" and node:parent():type() ~= "declaration") and max_distance > 0) do
      print(node:type())
      print("\n")
      if node:type() == "identifier" then
        return nil
      end
      node = node:parent()
      max_distance = max_distance - 1
    end

    if max_distance == 0 then
      return nil
    end
    return node
end

-- ==============
-- Functions
-- ==============
function M.test(pre, post)
    print(pre)
    print(post)
    if (pre == nil or post == nil) then
      return
    end

    local node = get_qualified_node_under_cursor()
    if (node == nil) then
      return
    end

    print("found")
    print(node:range())
    print(node:type())
    print(vim.g.variable)

    local a,b,c,d = node:range()
    local content = vim.api.nvim_buf_get_lines(0, c, c+1, false)
    local identifier = string.sub(table.concat(content), b + 1, d)
    local mod_identifier = pre .. identifier .. post

    print(identifier)
    print(mod_identifier)
    vim.api.nvim_buf_set_text(0, a, b, c, d, {mod_identifier,})
end

function M.attach(bufnr, lang) end

function M.detach(bufnr) end


return {test=M.test}
