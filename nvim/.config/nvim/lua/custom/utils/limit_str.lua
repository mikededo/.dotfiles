---@param str string
---@return string
return function(str)
  if #str > 18 then
    str = string.sub(str, 1, 15) .. '...'
  end
  return str
end
