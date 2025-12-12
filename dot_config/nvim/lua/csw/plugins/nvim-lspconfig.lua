-- textDocument/diagnostic support until 0.10.0 is released

local function setup_diagnostics(client, buffer)
  if require("vim.lsp.diagnostic")._enable then
    return
  end

  local params = vim.lsp.util.make_text_document_params(buffer)
  client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
    if err then
      local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
      vim.lsp.log.error(err_msg)
    end
    local diagnostic_items = {}
    if result then
      diagnostic_items = result.items
    end
    vim.lsp.diagnostic.on_publish_diagnostics(
      nil,
      vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
      { client_id = client.id }
    )
  end)
end

local key_bindings = function(client)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })

  -- map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
  -- ^ code action options to take against diagnostics
end

return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Setup language servers using new vim.lsp.config API (nvim 0.11+)
    vim.lsp.config('ruby_lsp', {
      on_attach = function(client, buffer)
        print("LSP started.");

        vim.diagnostic.disable()

        key_bindings(client)
        setup_diagnostics(client, buffer)
      end
    })

    -- Enable the LSP server
    vim.lsp.enable('ruby_lsp')
  end
}
