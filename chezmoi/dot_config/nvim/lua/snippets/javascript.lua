-- lua/snippets/javascript.lua
local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

-- 関数シグネチャを解析してパラメータと戻り値を抽出する関数
local function get_function_info()
    local current_line = vim.fn.line('.')
    local next_line = vim.fn.getline(current_line + 3)

    local params = {}
    local has_return = false

    -- アロー関数のパターン
    local signature = next_line:match('%((.-)%)%s*=>')

    -- 通常の関数のパターン
    if not signature then
        signature = next_line:match('function%s*[^(]*%((.-)%)')
    end

    -- メソッド定義のパターン
    if not signature then
        signature = next_line:match('^%s*[%w_]+%s*%((.-)%)')
    end

    if signature and signature ~= '' then
        for param in signature:gmatch('([^,]+)') do
            local param_trimmed = param:match('^%s*(.-)%s*$')
            if param_trimmed and param_trimmed ~= '' then
                -- TypeScriptの型アノテーションを除去 (例: param: string)
                local param_name = param_trimmed:match('^([%w_]+)')
                if param_name then
                    table.insert(params, param_name)
                end
            end
        end
    end

    -- アロー関数は戻り値ありと判定
    if next_line:match('=>') then
        has_return = true
    end

    return params, has_return
end

-- 現在のファイルタイプを取得
local function is_typescript()
    local ft = vim.bo.filetype
    return ft == 'typescript' or ft == 'typescriptreact'
end

-- パラメータのドキュメント行を動的に生成
local function generate_param_docs(_, snip)
    local params, _ = get_function_info()
    local nodes = {}

    for idx, param in ipairs(params) do
        if is_typescript() then
            -- TypeScript: 型指定なし
            table.insert(nodes, t({ '', ' * @param ' .. param .. ' ' }))
            table.insert(nodes, i(idx, '説明'))
        else
            -- JavaScript: 型指定あり
            table.insert(nodes, t({ '', ' * @param {' }))
            table.insert(nodes, i(idx * 2, 'type'))
            table.insert(nodes, t('} ' .. param .. ' - '))
            table.insert(nodes, i(idx * 2 + 1, '説明'))
        end
    end

    return sn(nil, nodes)
end

-- 戻り値のドキュメント行を動的に生成
local function generate_return_doc(_, snip)
    local _, has_return = get_function_info()

    if has_return then
        if is_typescript() then
            -- TypeScript: 型指定なし
            return sn(nil, {
                t({ '', ' * @returns ' }),
                i(1, '戻り値の説明'),
            })
        else
            -- JavaScript: 型指定あり
            return sn(nil, {
                t({ '', ' * @returns {' }),
                i(1, 'type'),
                t('} '),
                i(2, '戻り値の説明'),
            })
        end
    else
        return sn(nil, { t('') })
    end
end

return {
    -- /** で展開されるJSDocスニペット
    s({
        trig = '/**',
        wordTrig = true,
    }, {
        t({ '/**', ' * ' }),
        i(1, 'description'),
        d(2, generate_param_docs, {}),
        d(3, generate_return_doc, {}),
        t({ '', ' */' }),
    }),
    -- jsdoc でも展開できるようにする（バックアップ）
    s('jsdoc', {
        t({ '/**', ' * ' }),
        i(1, '説明'),
        t({ '', ' */' }),
    }),
}
