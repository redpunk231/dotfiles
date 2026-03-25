local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

vim.lsp.config('pyright', {
  capabilities = capabilities,
})
vim.lsp.enable('pyright')
