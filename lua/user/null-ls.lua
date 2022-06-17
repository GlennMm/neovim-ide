local null_ls_ok, null_ls = pcall(require, 'null_ls')

if not null_ls_ok then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local formatting = null_ls.builtins.formatting
local diagnosis = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    -- formatting
    formatting.prettier_d.with({ extra_args = { "--no-semi", "--single-quotes" }}),
    formatting.black,
    formatting.dart_format,
    formatting.rustfmt,
    formatting.rustywind,
    -- diagnosis
    diagnosis.flake8,
    diagnosis.golangci_lint,

    -- code actions
    code_actions.eslint_d,

  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
