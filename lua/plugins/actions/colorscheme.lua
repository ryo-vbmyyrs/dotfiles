-- https://www.colordic.org/#google_vignette
local c_common = {
    black = '#000000',
    gray = '#808080',
    darkgray = '#a9a9a9',
    lightgray = '#d3d3d3',
    white = '#ffffff',
    snow = '#fffafa',
    linen = '#faf0e6',
    ivory = '#fffff0',
    honeydew = '#f0fff0',
    azure = '#f0ffff',

    aliceblue = '#f0f8ff',
    lavender = '#e6e6fa',
    royalblue = '#4169e1',
    navy = '#000080',
    blue = '#0000ff',
    skyblue = '#87cefa',
    powderblue = '#b0e0e6',
    turquoise = '#40e0d0',

    darkgreen = '#006400',
    green = '#008000',
    aquamarine = '#7fffd4',
    palegreen = '#98fb98',

    lightyellow = '#ffffe0',
    wheat = '#f5deb3',
    khaki = '#f0e68c',
    yellow = '#ffff00',
    orange = '#ffa500',
    indianred = '#cd5c5c',
    red = '#ff0000',
    deeppink = '#ff1493',
    lightpink = '#ffb6c1',

    magenta = '#ff00ff',
    violet = '#ee82ee',
    orchid = '#da70d6',
    darkviolet = '#9400d3',
    purple = '#800080',
    mediumpurple = '#9370db',
    mediumslateblue = '#7b68ee',
}

-- https://www.pilot.co.jp/library/010/
local c_iroshizuku = {
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
    RyoPmenuBorder = { fg = c_iroshizuku.ajisai },
    AvanteSidebarWinSeparator = { fg = c_iroshizuku.asagao },
    TreesitterContext = { bg = '#51504f' },
}

local set_hl = function(tbl)
    for group, conf in pairs(tbl) do
        vim.api.nvim_set_hl(0, group, conf)
    end
end
set_hl(hl)
