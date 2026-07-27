-- IDE-style breadcrumbs in the winbar: a > m > company.rb > Company > #owner
-- Path segments come from the filesystem, symbol segments from LSP/treesitter.
-- Each crumb is clickable and <leader>; opens a jump-to-crumb picker.
--
-- Three transforms sit on top of dropbar's stock path source:
--   1. Rails scaffolding directories collapse to a letter or two plus an icon.
--   2. Files inside a gem root at the gem name instead of walking up to /.
--   3. Anything still too deep keeps its tail and gets a clickable "…".

-- Directories whose names you already know by heart. Abbreviated to the shortest
-- prefix that stays unambiguous *within its own group* -- the icon does the rest
-- of the disambiguating. Anything not listed here keeps its full name, which is
-- the point: `public_api`, `v1`, `integrations` are the parts worth reading.
local ABBREV = {
  -- repo root
  app         = { "a",   "󰘔 ", "DropBarIconKindModule" },
  spec        = { "sp",  "󰙨 ", "DropBarIconKindEvent" },
  lib         = { "l",   "󰂺 ", "DropBarIconKindModule" },
  config      = { "cfg", "󰒓 ", "DropBarIconKindProperty" },
  db          = { "db",  "󰆼 ", "DropBarIconKindStruct" },
  e2e         = { "e2e", "󰙨 ", "DropBarIconKindEvent" },
  docs        = { "doc", "󰈙 ", "DropBarIconKindFile" },

  -- under app/
  models      = { "m",   "󰆼 ", "DropBarIconKindClass" },
  controllers = { "c",   "󰑮 ", "DropBarIconKindFunction" },
  views       = { "v",   "󰈔 ", "DropBarIconKindFile" },
  services    = { "s",   "󰒓 ", "DropBarIconKindMethod" },
  jobs        = { "j",   "󰅩 ", "DropBarIconKindEvent" },
  helpers     = { "h",   "󰘳 ", "DropBarIconKindMethod" },
  queries     = { "q",   "󰈞 ", "DropBarIconKindOperator" },
  notifiers   = { "n",   "󰂚 ", "DropBarIconKindEvent" },
  tasks       = { "t",   "󰃰 ", "DropBarIconKindOperator" },
  utils       = { "u",   "󰘦 ", "DropBarIconKindMethod" },
  policies    = { "po",  "󰒃 ", "DropBarIconKindProperty" },
  prompts     = { "pr",  "󰧑 ", "DropBarIconKindString" },
  mailers     = { "ma",  "󰇮 ", "DropBarIconKindEvent" },
  channels    = { "ch",  "󰭹 ", "DropBarIconKindEvent" },
  concerns    = { "cn",  "󰌷 ", "DropBarIconKindInterface" },
  serializers = { "sz",  "󰘦 ", "DropBarIconKindStruct" },
  subscribers = { "sub", "󰡉 ", "DropBarIconKindEvent" },
  interactors = { "it",  "󰐕 ", "DropBarIconKindMethod" },
  indexes     = { "ix",  "󰋇 ", "DropBarIconKindArray" },
  inputs      = { "in",  "󰌌 ", "DropBarIconKindField" },
  graphql     = { "gq",  "󰡷 ", "DropBarIconKindInterface" },
  frontend    = { "fe",  "󰜈 ", "DropBarIconKindModule" },
  assets      = { "as",  "󰉏 ", "DropBarIconKindFile" },
  ai          = { "ai",  "󰧑 ", "DropBarIconKindModule" },
  pdf         = { "pdf", "󰈦 ", "DropBarIconKindFile" },
}

-- Keep this many crumbs when a path is too deep; everything above collapses
-- into a single "…". Counts path crumbs only -- LSP symbol crumbs are appended
-- by a separate source and are never truncated.
local MAX_CRUMBS = 5

-- Innermost `/gems/<name>` in a path, e.g.
--   ~/.local/…/gems/3.4.0/gems/activerecord-8.0.5/lib/…
--                            ^^^^^^^^^^^^^^^^^^^^ this one, not the 3.4.0 above it
---@return string? root full path to the gem directory
local function gem_root(path)
  local root, from = nil, 1
  while true do
    local s, e = path:find("/gems/[^/]+", from)
    if not s then break end
    root, from = path:sub(1, e), s + 1
  end
  return root
end

-- Wraps dropbar's path source. Every transform mutates the stock symbol list in
-- place rather than building new symbols, so each crumb keeps its real
-- `data.path` -- click-to-navigate, the dropdown, and previews all still work,
-- including on the "…".
local function rails_path_source()
  local path_source = require("dropbar.sources").path

  return {
    get_symbols = function(buf, win, cursor)
      local symbols = path_source.get_symbols(buf, win, cursor)
      if #symbols == 0 then
        return symbols
      end

      -- 1. Gem files: drop everything above the gem directory. Without this a
      -- single `gd` into activerecord costs 11 crumbs of $HOME and mise noise.
      local root = gem_root(vim.fs.normalize(vim.api.nvim_buf_get_name(buf)))
      if root then
        for i, sym in ipairs(symbols) do
          if sym.data and sym.data.path == root then
            for _ = 1, i - 1 do
              table.remove(symbols, 1)
            end
            symbols[1].icon = "󰏗 "
            symbols[1].icon_hl = "DropBarIconKindPackage"
            break
          end
        end
      else
        -- 2. Abbreviate known scaffolding. Only directories, never the filename,
        -- which is always the last symbol.
        for i = 1, #symbols - 1 do
          local a = ABBREV[symbols[i].name]
          if a then
            symbols[i].name, symbols[i].icon, symbols[i].icon_hl = a[1], a[2], a[3]
          end
        end
      end

      -- 3. Still too deep? Collapse the middle, never the ends. The first crumb
      -- is the anchor you actually navigate by -- the gem name, or `a`/`sp` --
      -- so it survives; only the stretch between it and the tail becomes "…".
      -- The "…" reuses the deepest elided directory's symbol, so clicking it
      -- opens that directory rather than being dead text.
      if #symbols > MAX_CRUMBS then
        local keep = MAX_CRUMBS - 2 -- anchor + "…" + this many tail crumbs
        local anchor = table.remove(symbols, 1)
        local elided
        while #symbols > keep do
          elided = table.remove(symbols, 1)
        end
        elided.name, elided.icon, elided.icon_hl = "…", "", "DropBarIconKindFolder"
        table.insert(symbols, 1, elided)
        table.insert(symbols, 1, anchor)
      end

      return symbols
    end,
  }
end

return {
  "Bekaboo/dropbar.nvim",
  dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
  -- Not lazy-loaded: the winbar has to exist for the very first buffer, and
  -- BufReadPost fires too early to be a reliable trigger when nvim is given a
  -- file argument.
  lazy = false,
  config = function()
    local sources = require("dropbar.sources")
    local utils = require("dropbar.utils")
    local rails_path = rails_path_source()

    require("dropbar").setup({
      bar = {
        -- Don't draw a winbar in the file tree, terminals, or floating windows
        enable = function(buf, win, _)
          if vim.api.nvim_win_get_config(win).zindex ~= nil then return false end
          local ft = vim.bo[buf].filetype
          if ft == "NvimTree" or ft == "help" or ft == "floaterm" then return false end
          return vim.bo[buf].buftype == ""
        end,
        -- Mirrors dropbar's default source list, with the Rails-aware path
        -- source swapped in for the stock one.
        sources = function(buf, _)
          if vim.bo[buf].ft == "markdown" then
            return { rails_path, sources.markdown }
          end
          if vim.bo[buf].buftype == "terminal" then
            return { sources.terminal }
          end
          return {
            rails_path,
            utils.source.fallback({ sources.lsp, sources.treesitter }),
          }
        end,
      },
      sources = {
        path = {
          -- Root breadcrumbs at the project root, not $HOME
          relative_to = function(_, win)
            local ok, cwd = pcall(vim.fn.getcwd, win)
            return ok and cwd or vim.fn.getcwd()
          end,
        },
      },
    })

    vim.keymap.set("n", "<leader>;", require("dropbar.api").pick, { desc = "Pick breadcrumb" })
  end,
}
