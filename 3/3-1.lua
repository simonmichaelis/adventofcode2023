file = io.open("input.txt", "r")


-- if a number is adjacent to a potential gear, register the number for that potential gear
function registerGear(LineIndex, StartPos, adjacentNumber)
  local id = LineIndex .. "-" .. StartPos

  if potentialGears[id] == nil then
    potentialGears[id] = { adjacentNumber }
  else
    table.insert(potentialGears[id], adjacentNumber)
  end
end


-- check if a string contains a Marker (=Special character but not ".")
function isMarker(Char)
  if string.match(Char, "[^%d%.]") then
    return true
  else
    return false
  end
end


-- function to check if a number is next to a marker
function hasMarkers(LineIndex, StartPos, EndPos)
  local partNo = string.sub(allLines[LineIndex], StartPos, EndPos)
  local Markers = 0

  -- check on the left
  if StartPos > 1 then
    local left = string.sub(allLines[LineIndex], StartPos - 1, StartPos - 1)
    if isMarker(left) then
      Markers = Markers + 1
    end

    if left == "*" then
      registerGear(LineIndex, StartPos - 1, partNo)
    end
  end

  -- check on the right
  if EndPos < #allLines[LineIndex] then
    local right = string.sub(allLines[LineIndex], EndPos + 1, EndPos + 1)
    if isMarker(right) then
      Markers = Markers + 1
    end

    if right == "*" then
      registerGear(LineIndex, EndPos + 1, partNo)
    end
  end

  -- add diagonal tops and bottoms if not at the end or beginning of line
  local startAboveBelow = StartPos
  local endAboveBelow  = EndPos
  
  if StartPos > 1 then
    startAboveBelow  = StartPos - 1
  end
  
  if EndPos < #allLines[1] then
    endAboveBelow  = EndPos +1
  end

  -- check above
  if LineIndex > 1 then
    local top = string.sub(allLines[LineIndex - 1], startAboveBelow , endAboveBelow )
    if isMarker(top) then
      Markers = Markers + 1
    end

    if string.find(top, "%*") then
      local gearPos = startAboveBelow + string.find(top, "%*") - 1
      registerGear(LineIndex - 1, gearPos, partNo)
    end
  end

  -- check below
  if LineIndex < #allLines then
    local below = string.sub(allLines[LineIndex + 1], startAboveBelow , endAboveBelow )

    if isMarker(below) then
      Markers = Markers + 1
    end

    if string.find(below, "%*") then
      local gearPos = startAboveBelow + string.find(below, "%*") - 1
      registerGear(LineIndex + 1, gearPos, partNo)
    end
  end

  if Markers == 0 then
    return nil
  else
    return Markers
  end
end


function findMany(String, Pattern)
  local finds = {}
  local keepSearching = true
  local nextStartPos = 0

  while keepSearching do
    local startPos, endPos = string.find(String, Pattern, nextStartPos)

    if startPos == nil then
      keepSearching = false
    else
      table.insert(finds, { startPos, endPos })
      nextStartPos = endPos + 1
    end
  end

  return ipairs(finds)
end


-- store all lines in an array
allLines = {}

for line in file:lines() do
  table.insert(allLines, line)
end


local sumofPartNos = 0
potentialGears = {}


-- iterate over each line
for index, line in ipairs(allLines) do
  -- find the numbers in each line (Lua doesn't offer a find multiple function,
  -- so we have to do it ourselves)
  local keepSearching = true
  local nextStartPos = 0

  while keepSearching do
    local startPos, endPos = string.find(line,"%d+", nextStartPos)

    if startPos == nil then
      keepSearching = false
    else
      if hasMarkers(index, startPos, endPos) then
        local partNo = string.sub(line, startPos, endPos)
        print("PartNo: " .. partNo)
        sumofPartNos = sumofPartNos + partNo 
      end
      nextStartPos = endPos + 1
    end
  end
end


print("-----------------------------------")
print(sumofPartNos)


-- find gears and generate sum of gear ratios
local sumOfGearRatios = 0

for index, numbers in pairs(potentialGears) do
  if #numbers == 2 then
    sumOfGearRatios = sumOfGearRatios + (numbers[1] * numbers[2])
  end
end

print(sumOfGearRatios)