-- LSP Mappings
vim.keymap.set('n', '<space>d',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<space>.', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<space>ra', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
-- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')

-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = {
    prefix = '●'
  }
})
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local lspconfig = require('lspconfig')

-- Leading keys to use LSP function
local leader = '<LocalLeader>'

-- Custom border of hover window
_G.__MyLspFloatingOpts = {
  focusable = false,
  border = {
    {'+', 'FloatBorder'},
    {'-', 'FloatBorder'},
    {'+', 'FloatBorder'},
    {'|', 'FloatBorder'},
    {'+', 'FloatBorder'},
    {'-', 'FloatBorder'},
    {'+', 'FloatBorder'},
    {'|', 'FloatBorder'},
  },
}

local on_attach = function(client, bufnr)
  local function lspmap(m) return leader .. m end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, _G.__MyLspFloatingOpts)

  -- Highlight a symbol and its references when holding the cursor
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup MyAutoCmdLspDocumentHighlight
        autocmd! * <buffer>
        autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  -- Show diagnostics which current line includes
  vim.api.nvim_exec([[
    augroup MyAutoCmdLspDiagnostics
      autocmd!
      autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(0, _G.__MyLspFloatingOpts)
    augroup END
  ]], false)

  -- Add `:Format` command
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', lspmap('f'), '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('n', lspmap('f'), '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end
end

local lsp_settings = {
  bashls = {},
  denols = {
    root_dir = lspconfig.util.root_pattern("deno.json"),
    init_options = { lint = true },
  },
  dockerls = {},
  gopls = {},
  html = {},
  jsonls = {},
  solargraph = {},
  sumneko_lua = {},
  terraformls = {},
  tflint = {},
  tsserver = {
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json"),
  },
  vimls = {},
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          kubernetes = "/*.yaml",
          ["https://json.schemastore.org/ansible-playbook.json"] = { "/playbook.yml", "/ansible/*.yml" },
          ["https://json.schemastore.org/ansible-role-2.9.json"] = { "/roles/tasks/*.yml" },
        },
      },
    },
  },
}

local required_server_names = {}
for server_name, _ in pairs(lsp_settings) do
  table.insert(required_server_names, server_name)
end

local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('mason').setup {
}

require('mason-lspconfig').setup {
  ensure_installed = required_server_names
}

require('mason-lspconfig').setup_handlers {
  function(server_name)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
    -- Override settings
    if lsp_settings[server_name] ~= nil then
      for k, v in pairs(lsp_settings[server_name]) do
        opts[k] = v
      end
    end
    lspconfig[server_name].setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
  end,
}

require("trouble").setup {}
vim.keymap.set("n", "<space>e", "<cmd>TroubleToggle<cr>")
