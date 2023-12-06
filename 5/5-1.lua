
-- parse input file line by line into table (array)
local file = io.open("input.txt", "r")
local lines = {}

-- put all lines into a table
for line in file:lines() do
  table.insert(lines, line)
end


-- parses a line of map coordinates into an easily readable table
function parseMap(String)  
  local numbers = {}

  for number in string.gmatch(String, "%d+") do
    table.insert(numbers, number)
  end

  return {
    destination = tonumber(numbers[1]),
    source = tonumber(numbers[2]),
    length = tonumber(numbers[3])
  }
end


-- parse Mappings
local maps = {}
local currentMapId
local currentMapLines = {}

for i = 3,  #lines, 1 do
  local a, b = string.find(lines[i], "%a+%-%a+%-%a+")

  if a ~= nil then
    currentMapId = string.sub(lines[i], a, b)
    print("Parsing " .. currentMapId .. " mappings..")
  end

  if a == nil then
    if string.find(lines[i], "%d") then
      table.insert(currentMapLines, parseMap(lines[i]))
    else
      table.insert(maps, {
        id = currentMapId,
        mappings = currentMapLines
      })
      currentMapId = nil
      currentMapLines = {}
    end
  end
end


-- Find a target location in a map (map needs to be an array of multiple map lines)
function mapLocation(SourceLocation, Maps)
  local targetLocation = SourceLocation

  for index, map in ipairs(Maps) do
    if SourceLocation >= map.source and SourceLocation <= (map.source + map.length) then
      local relativePos = SourceLocation - map.source
      targetLocation =  map.destination + relativePos
    end  
  end

  return targetLocation
end


-- parse seeds & find lowest location number
local lowestLocation
print("-------------------------------------")

for seed in string.gmatch(lines[1], "%d+") do
  seed = tonumber(seed)
  print("Finding location for seed no. " .. seed)

  local currentSource = seed

  for index, map in ipairs(maps) do
    print("Mapping "..map.id)
    currentSource = mapLocation(currentSource, map.mappings)
    print(map.id..": "..currentSource)
  end

  if not lowestLocation then
    lowestLocation = currentSource
  elseif currentSource < lowestLocation then
    lowestLocation = currentSource
  end

  print("-------------------------------------")
end

print("Lowest location: "..lowestLocation)

