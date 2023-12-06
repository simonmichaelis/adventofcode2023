
-- parse file
local file = io.open("input.txt", "r")
local lines = {}

for line in file:lines() do
 table.insert(lines, line)
end


-- parse times and distances

local times = {}

for time in string.gmatch(lines[1], "%d+") do
  table.insert(times, time)
end

local distances = {}

for distance in string.gmatch(lines[2], "%d+") do
  table.insert(distances, tonumber(distance))
end


-- calculate how many options exist to win a race

local result = 1

for index, time in ipairs(times) do
  local winOptions = 0

  for i = 1, time - 1, 1 do
    local distance = (time - i) * i
    if distance > distances[index] then
      print(i)
      winOptions = winOptions + 1
    end
  end

  result = result * winOptions

  print("---------")
end

print(result)
