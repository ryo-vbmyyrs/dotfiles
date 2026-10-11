-- Mason で自動インストールする LSP 以外のツール。LSP サーバーは mason-lspconfig.lua に書く
local ensure_installed = { 'prettier', 'stylua' }

return {
    'mason-org/mason.nvim',
    opts = {
        registries = {
            'github:mason-org/mason-registry',
        },
    },
    config = function(_, opts)
        require('mason').setup(opts)

        local registry = require('mason-registry')
        registry.refresh(function()
            for _, name in ipairs(ensure_installed) do
                local pkg = registry.get_package(name)
                if not pkg:is_installed() and not pkg:is_installing() then
                    pkg:install()
                end
            end
        end)
    end,
}
