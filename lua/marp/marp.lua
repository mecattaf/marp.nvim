local util = require("marp/util")
local config = require("marp/config")

local M = {}
local zathura_pid = nil

local function open_pdf_in_zathura(pdf_output)
    -- Close any previously opened Zathura process
    if zathura_pid then
        vim.fn.jobstop(zathura_pid)
        zathura_pid = nil
    end

    -- Start Zathura and capture its PID for later management
    local cmd = string.format("zathura %s & echo $!", pdf_output)
    zathura_pid = vim.fn.jobstart(cmd, {
        on_stdout = function(_, data)
            -- Assuming the PID is the only output
            zathura_pid = tonumber(data[1])
        end,
        stdout_buffered = true,
    })
end

function M.start()
    local current_file = vim.api.nvim_buf_get_name(0)
    if not current_file:match(".md$") then
        util.log_info("Not a Markdown file.")
        return
    end

    local html_output = current_file:gsub("%.md$", ".html")
    local pdf_output = current_file:gsub("%.md$", ".pdf")
    local marp_command = string.format("/var/home/dev/.local/share/bin/marp %s --theme-set %s -o %s", current_file, config.options.theme, html_output)

    vim.fn.jobstart(marp_command, {
        on_exit = function(_, exit_code)
            if exit_code == 0 then
                util.log_info("Markdown converted to HTML successfully.")
                local pandoc_command = string.format("pandoc %s -o %s", html_output, pdf_output)
                vim.fn.jobstart(pandoc_command, {
                    on_exit = function(_, pandoc_exit_code)
                        if pandoc_exit_code == 0 then
                            util.log_info("HTML converted to PDF successfully.")
                            open_pdf_in_zathura(pdf_output)
                        else
                            util.log_error("Failed to convert HTML to PDF.")
                        end
                    end,
                })
            else
                util.log_error("Failed to convert Markdown to HTML.")
            end
        end,
    })
end

function M.stop()
    if zathura_pid then
        vim.fn.jobstop(zathura_pid)
        zathura_pid = nil
        util.log_info("Zathura process stopped.")
    else
        util.log_info("No Zathura process was running.")
    end
end

return M

