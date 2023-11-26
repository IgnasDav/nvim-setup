local conform = require("conform")

conform.setup {
    formatters_by_ft = {
        swift = { "swiftformat" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
    log_level = vim.log.levels.ERROR,
}

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
