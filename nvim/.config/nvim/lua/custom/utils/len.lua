---Returns table length
---@param t table
---@return integer
return function(t)
  local c = 0
  for _, _ in ipairs(t) do
    c = c + 1
  end
  return c
end
