-- lua/snippets/java.lua
local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

-- メソッドシグネチャを解析してパラメータと戻り値を抽出する関数
local function get_method_info()
    local current_line = vim.fn.line('.')

    -- アノテーションをスキップしてメソッド定義の開始行を探す
    local method_start_line = nil
    for offset = 3, 10 do
        local line = vim.fn.getline(current_line + offset)
        if not line:match('^%s*@') and line:match('%(') then
            method_start_line = current_line + offset
            break
        end
    end

    local params = {}
    local return_type = 'void'
    local throws = {}

    if not method_start_line then
        return params, return_type, throws
    end

    -- メソッド定義を複数行結合して取得（開き波括弧まで）
    local full_signature = ''
    for offset = 0, 10 do
        local line = vim.fn.getline(method_start_line + offset)
        full_signature = full_signature .. ' ' .. line
        if line:match('{') then
            break
        end
    end

    -- メソッドシグネチャのパターンマッチング
    local signature = full_signature:match('%((.-)%)')

    if signature and signature ~= '' then
        -- パラメータを分割
        for param in signature:gmatch('([^,]+)') do
            local param_trimmed = param:match('^%s*(.-)%s*$')
            if param_trimmed and param_trimmed ~= '' then
                -- アノテーション（@Valid, @RequestBody等）を除去
                param_trimmed = param_trimmed:gsub('@%w+%s+', '')

                -- 型名とパラメータ名を分離
                local parts = {}
                for word in param_trimmed:gmatch('%S+') do
                    table.insert(parts, word)
                end
                if #parts >= 2 then
                    local param_name = parts[#parts]
                    table.insert(params, param_name)
                end
            end
        end
    end

    -- 戻り値の型を取得
    local return_match = full_signature:match('^%s*[^%s]+%s+([^%s<]+)')
    if return_match and return_match ~= 'void' then
        return_type = return_match
    end

    -- throws句を解析
    local throws_clause = full_signature:match('throws%s+([^{]+)')
    if throws_clause then
        for exception in throws_clause:gmatch('([^,]+)') do
            local exception_trimmed = exception:match('^%s*(.-)%s*$')
            if exception_trimmed and exception_trimmed ~= '' then
                table.insert(throws, exception_trimmed)
            end
        end
    end

    return params, return_type, throws
end

-- パラメータのドキュメント行を動的に生成
local function generate_param_docs(_, snip)
    local params, _, _ = get_method_info()
    local nodes = {}

    for idx, param in ipairs(params) do
        table.insert(nodes, t({ '', ' * @param ' .. param .. ' ' }))
        table.insert(nodes, i(idx + 1))
    end

    return sn(nil, nodes)
end

-- 戻り値のドキュメント行を動的に生成
local function generate_return_doc(_, snip)
    local _, return_type, _ = get_method_info()

    if return_type and return_type ~= 'void' then
        return sn(nil, {
            t({ '', ' * @return ' }),
            i(1),
        })
    else
        return sn(nil, { t('') })
    end
end

-- throws句のドキュメント行を動的に生成
local function generate_throws_docs(_, snip)
    local _, _, throws = get_method_info()
    local nodes = {}

    for idx, exception in ipairs(throws) do
        table.insert(nodes, t({ '', ' * @throws ' .. exception .. ' ' }))
        table.insert(nodes, i(idx))
    end

    return sn(nil, nodes)
end

return {
    -- /** で展開されるJavadocスニペット
    s({
        trig = '/**',
        wordTrig = true,
    }, {
        t({ '/**', ' * ' }),
        i(1),
        d(2, generate_param_docs, {}),
        d(3, generate_return_doc, {}),
        d(4, generate_throws_docs, {}),
        t({ '', ' */' }),
    }),
    -- jdoc でも展開できるようにする（バックアップ）
    s('jdoc', {
        t({ '/**', ' * ' }),
        i(1),
        t({ '', ' */' }),
    }),
}
