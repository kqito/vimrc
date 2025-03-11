---@diagnostic disable: undefined-global

vim.api.nvim_create_user_command('WriteAsRoot', function()
  vim.cmd(':w !sudo tee > /dev/null %')
end, {})
