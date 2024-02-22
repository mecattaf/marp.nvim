local M = {}

local defaults = {
  port = 5001, -- Updated port
  wait_for_response_timeout = 30,
  wait_for_response_delay = 1,
  theme = "/var/home/dev/.config/marp/mocha.css",
}

M.options = {}

function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, defaults, options or {})
end

M.setup()

return M  
