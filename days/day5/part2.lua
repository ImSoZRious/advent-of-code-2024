function split(str, sep)
  local ret = {}
  for v in string.gmatch(str, "([^" .. sep .. "]+)") do
    table.insert(ret, v)
  end
  return ret
end

local rules = {}

while true do
  local line = io.read()
  if line == nil then
    break
  end

  line = string.gsub(line, "%s+", "")

  if line == '' then
    break
  end

  local rule = split(line, "|")

  table.insert(rules, rule)
end

local ruleMap = {}

for _, rule in ipairs(rules) do
  local a, b = table.unpack(rule)

  if ruleMap[b] == nil then
    ruleMap[b] = {}
  end
  
  table.insert(ruleMap[b], a)
end

local sum = 0

while true do
  local line = io.read()

  if line == nil then
    break
  end

  line = string.gsub(line, "%s+", "")

  if line == '' then
    break
  end

  local num = split(line, ",")

  local banned = {}
  local valid = true

  for _, v in ipairs(num) do
    if banned[v] == true then
      valid = false
      break
    end

    if ruleMap[v] ~= nil then
      for _, v in ipairs(ruleMap[v]) do
        banned[v] = true
      end
    end
  end

  if not valid then
    local exists = {}

    for _, v in ipairs(num) do
      exists[v] = true
    end

    local l = {}
    local r = {}
    
    for _, rule in ipairs(rules) do
      local ll, rr = table.unpack(rule)
      if exists[ll] ~= nil and exists[rr] ~= nil then
        if l[ll] == nil then
          l[ll] = 0
        end
        if r[rr] == nil then
          r[rr] = 0
        end
        if r[ll] == nil then
          r[ll] = 0
        end
        if l[rr] == nil then
          l[rr] = 0
        end
        l[ll] = l[ll] + 1
        r[rr] = r[rr] + 1
      end
    end
    
    for _, v in ipairs(num) do
      if l[v] == r[v] then
        sum = sum + v
      end
    end
  end
end

print(sum)
