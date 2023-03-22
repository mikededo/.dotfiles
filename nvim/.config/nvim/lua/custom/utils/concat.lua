local len = require('custom.utils.len')

---Returns concatenated tables
---@generic T
---@generic K
---@param t1 T[]
---@param t2 K[]
---@return (K|T)[]
return function(t1, t2)
  if len(t1) == 0 then
    return t2
  elseif len(t2) == 0 then
    return t1
  end

  local c = t1
  for _, v2 in ipairs(t2) do
    table.insert(t1, len(t1) + 1, v2)
  end
  return c
end
