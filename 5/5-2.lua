
local startTime = os.time()


local partTwo = true
local file = io.open("input.txt", "r")


-- parse input file line by line into table (array)
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
    if SourceLocation >= map.source and SourceLocation <= (map.source + map.length - 1) then
      local relativePos = SourceLocation - map.source
      local newTargetLocation = map.destination + relativePos
      targetLocation = newTargetLocation
      break
    end
  end

  return targetLocation
end


-- parse seeds & find lowest location number
local lowestLocation = 10000000000000
print("-------------------------------------")

local seeds

local manySeeds = {}

for pair in string.gmatch(lines[1], "%d+ %d+") do
  local parsedpair = {}

  for number in string.gmatch(pair, "%d+") do
    table.insert(parsedpair, tonumber(number))
  end

  local rangeStart = parsedpair[1]
  local rangeEnd = parsedpair[1] + parsedpair[2] - 1

  for i = rangeStart, rangeEnd, 1 do
    --print("Searching location for seed "..i)
    local currentSource = i

    for index, map in ipairs(maps) do
      --currentSource = mapLocation(currentSource, map.mappings)
      local targetLocation = currentSource

      for index, map in ipairs(map.mappings) do
        if currentSource >= map.source and currentSource <= (map.source + map.length - 1) then
          targetLocation = map.destination + currentSource - map.source
          break
        end
      end
    
      currentSource = targetLocation
    end

    if currentSource < lowestLocation then
      lowestLocation = currentSource
      print(lowestLocation)
    end
  end
end

print("Lowest location: "..lowestLocation)

local stopTime = os.time()

print(os.difftime(stopTime, startTime))

--Lowest location: 604294014
--308.0

