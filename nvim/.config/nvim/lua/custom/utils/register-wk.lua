local present, wk = pcall(require, 'which-key')
if not present then
  print('which-key is not installed or not loaded')
  return
end

local len = require('custom.utils.len')

---Generates the build key table format expected for registering
---a key
---@param map string[]
---@param cmd string
---@param desc? string
---@return table
local build_which_key = function(map, cmd, desc)
  local map_len = len(map)
  local res
  for i, _ in ipairs(map) do
    local pos = map_len - i + 1
    if i == 1 then
      local def = { cmd }
      if desc ~= nil and desc ~= '' then
        table.insert(def, desc)
      end
      res = { [map[pos]] = def }
    else
      res = { [map[pos]] = res }
    end
  end
  return res
end

---Registers the given command into which-key
---@param map string[]
---@param cmd string
---@param mode 'n'|'i'|'v'
---@param desc? string
return function(map, cmd, mode, desc)
  wk.register(build_which_key(map, cmd, desc), { mode = mode })
end
