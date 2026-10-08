-- matchit の開きタグのパターンは、タグ名の捕捉がタグ名の途中で止まれる。
-- そのため <lightning-layout> の中の <lightning-layout-item> も <lightning-layout> の開きタグとして数えられ、
-- % で閉じタグへ移動できない。タグ名の直後に空白・>・行末が来るときだけ一致させる
if vim.b.match_words then
    vim.b.match_words = vim.b.match_words:gsub(
        vim.pesc([[\([^/!][^ \t>]*\)[^>]*]]),
        [[\([^/!][^ \t>]*\)\%([ \t>]\|$\)\@=[^>]*]]
    )
end
