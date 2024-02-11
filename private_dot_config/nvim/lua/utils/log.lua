local Log = {}

function Log:info(msg)
    vim.notify(msg, vim.log.levels.INFO)
end

function Log:error(msg)
    vim.notify(msg, vim.log.levels.ERROR)
end

return Log
