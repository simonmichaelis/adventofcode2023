
-- parse file
local file = io.open("input.txt", "r")
local lines = {}

for line in file:lines() do
 table.insert(lines, line)
end


-- parse times and distances

local time = ""

for t in string.gmatch(lines[1], "%d+") do
  time = time .. t
end

print("Time: " .. time)

local distance = ""

for d in string.gmatch(lines[2], "%d+") do
  distance = distance .. d
end

distance = tonumber(distance)

print("Distance: " .. distance)


-- calculate win options

local winOptions = 0

for i = 1, time - 1, 1 do
  local d = (time - i) * i
  if d > distance then
    print(i)
    winOptions = winOptions + 1
  end
end

print(winOptions)

