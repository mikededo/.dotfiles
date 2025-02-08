local M = {}

M.autoformat = true

function M.toggle()
	if vim.b.autoformat == false then
		vim.b.autoformat = nil
		M.autoformat = true
	else
		M.autoformat = not M.autoformat
	end
end

function M.enable()
	vim.b.autoformat = nil
	M.autoformat = true
end

function M.disable()
	M.autoformat = false
end

---@param opts? {force?:boolean}
function M.format(opts)
	local buf = vim.api.nvim_get_current_buf()
	local win = vim.api.nvim_get_current_win()

	if vim.b.autoformat == false and not (opts and opts.force) then
		return
	end

	local line, col = unpack(vim.api.nvim_win_get_cursor(win))
	vim.lsp.buf.format({
		bufnr = buf,
		timeout_ms = 500,
		filter = function(client)
			if not client.server_capabilities.documentFormattingProvider then
				return false
			end
			return true
		end,
	})

	line = math.min(line, vim.fn.line("$"))
	vim.api.nvim_win_set_cursor(win, { line, col })
end

local function command()
	vim.api.nvim_create_user_command("FormatToggle", M.toggle, { nargs = 0 })
	vim.api.nvim_create_user_command("FormatEnable", M.enable, { nargs = 0 })
	vim.api.nvim_create_user_command("FormatDisable", M.disable, { nargs = 0 })
	vim.api.nvim_create_user_command("Format", M.format, { nargs = 0 })
end

local function auto_format(buf)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
		buffer = buf,
		callback = function()
			if M.autoformat then
				M.format()
			end
		end,
	})
end

---@type fun(client: vim.lsp.Client, buffer: integer)
function M.on_attach(client, buf)
	if client.server_capabilities.documentFormattingProvider then
		command()
		auto_format(buf)
	end
end

---@param enabled boolean
function M.format_config(enabled)
  ---@param client vim.lsp.Client
  return function(client)
    client.server_capabilities.documentFormattingProvider = enabled
    client.server_capabilities.documentRangeFormattingProvider = enabled
  end
end

return M
