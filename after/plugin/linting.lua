local lint = require('lint')

local pattern = "[^:]+:(%d+):(%d+): (%w+): (.+)"
local groups = { "lnum", "col", "severity", "message" }
local defaults = { ["source"] = "swiftlint" }
local severity_map = {
    ["error"] = vim.diagnostic.severity.ERROR,
    ["warning"] = vim.diagnostic.severity.WARN,
}

lint.linters.swiftlint = {
    cmd = "swiftlint",
    stdin = true,
    args = {
        "lint",
        "--use-stdin",
        "--config",
        os.getenv("HOME") .. "/.config/nvim/.swiftlint.yml",
        "-",
    },
    stream = "stdout",
    ignore_exitcode = true,
    parser = require("lint.parser").from_pattern(pattern, groups, severity_map, defaults),
}

lint.linters_by_ft = {
    swift = { "swiftlint" },
}

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = lint_augroup,
    callback = function()
        require("lint").try_lint()
    end,
})

vim.keymap.set("n", "<leader>ml", function()
    require("lint").try_lint()
end, { desc = "Lint file" })
