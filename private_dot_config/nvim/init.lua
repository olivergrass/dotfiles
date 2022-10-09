local modules = {
    'user.disabled',
    'user.options',
    'user.keymaps',
    'user.plugins',
    'user.colorscheme',
}

for _, mod in ipairs(modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        error(('Error loading %s...\n\n%s'):format(mod, err))
    end
end

