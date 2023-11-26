-- require 'lspconfig'.sourcekit.setup {
--     cmd = { '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp' }
-- }
local lspconfig = require("lspconfig")
lspconfig.sourcekit.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp',
    },
    root_dir = function(filename, _)
        local git_root = lspconfig.util.find_git_ancestor(filename)
        return git_root
    end,
}
