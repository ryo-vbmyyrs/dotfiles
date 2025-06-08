
local c = {
    asagao = "#2663a4",
    ajisai = "#5373ae",
    tsuyukusa = "#3b91c2",
    konpeki = "#219dd0",
    amairo = "#4dbde3",
    tsukiyo = "#407587",
    kujaku = "#1d9ea3",
    shinkai = "#6c88af",
    syoro = "#388679",
    shinryoku = "#13815e",
    chikurin = "#a4b974",
    fuyusyogun = "#6f8696",
    kirisame = "#828083",
    takessumi = "#4e4e4e",
    tsutsuji = "#d6336c",
    kosumosu = "#ef829f",
    momiji = "#de5743",
    muraskishikibu = "#6c509a",
    yamabudo = "#8d387c",
    yuyake = "#f9983a",
    fuyugaki = "#f06e3a",
    inaho = "#9b7939",
    tsukushi = "#8c6663",
    yamaguri = "#56514e",
}

local hl = {
    RyoPmenuBorder = { fg = c.ajisai },
    AvanteSidebarWinSeparator = { fg = c.asagao },
}

local set_hl = function(tbl)
    for group, conf in pairs(tbl) do
        vim.api.nvim_set_hl(0, group, conf)
    end
end
set_hl(hl)
