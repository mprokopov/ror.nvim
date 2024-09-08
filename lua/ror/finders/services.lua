local M = {}

function M.find()
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local previewers = require "telescope.previewers"
  local conf = require("telescope.config").values

  local root_path = vim.fn.getcwd()
  local services = vim.split(vim.fn.glob(root_path .. "/app/services/**/*rb"), "\n")
  local parsed_services = {}
  for _, value in ipairs(services) do
    -- take only the filename without extension
    if value ~= "" then
      local parsed_filename = vim.fn.fnamemodify(value, ":~:.")
      table.insert(parsed_services, parsed_filename)
    end
  end

  if #parsed_services > 0 then
    local opts = {}
    pickers.new(opts, {
      prompt_title = "Services",
      finder = finders.new_table {
        results = parsed_services
      },
      previewer = previewers.vim_buffer_cat.new(opts),
      sorter = conf.generic_sorter(opts),
    }):find()
  end
end

return M
