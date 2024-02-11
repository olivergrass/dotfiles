local Log = require("utils.log")

local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    Log:error("Failed to load bufferline")
    return
end

bufferline.setup{
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                padding = 0,
                highlight = "PanelHeading",
                separator = false,
            },
        },
        indicator = { style = "none" },
        separator_style = { "", "" },
        always_show_bufferline = false,
        show_close_icon = false,
    }
}

