-- Day 2, Part 1: Cube Game

file = io.open("input.txt", "r")

limits = { red = 12, green = 13, blue = 14 }

sumOfPossibleGames = 0
sumOfPower = 0


function checkIfPossible(Draws, Limits)
  local isPossible = true

  for index, draw in pairs(Draws) do
    for color, value in pairs(draw) do
      if tonumber(value) > limits[color] then
        print("!game not possible because of " .. color)
        isPossible = false
      end
    end
  end

  return isPossible
end


function getLowestPossibleCubesPower(Draws)
  local red = 0
  local green = 0
  local blue = 0 
  
  for index, draw in ipairs(Draws) do
    for color, value in pairs(draw) do
      value = tonumber(value)
      if color == "red" and value > red then
        red = value
      elseif color == "green" and value > green then
        green = value
      elseif color == "blue" and value > blue then
        blue = value
      end
    end
  end

  return red * blue * green
end


for line in file:lines() do
  gameIdStart, gameIdEnd = string.find(line, "%d+")

  local gameId = string.sub(line, gameIdStart,gameIdEnd)
  local gameContent = string.sub(line, gameIdEnd+2)
  local draws = {}

  print("GameId " .. gameId)

  -- split the current game into draws and generate data structure for one game
  for d in string.gmatch(gameContent, "[^;]*") do
    local draw = {}

    -- remove trailing whitespace for everything that's not the first draw
    if string.sub(d, 1, 1) == " " then
      d = string.sub(d, 2)
    end

    -- split draws into colors
    for c in string.gmatch(d, "[^,]*") do
      -- remove trailing whitespace for everything except the first color
      if string.sub(c, 1, 1) == " " then
        c = string.sub(c, 2)
      end

      numberStart, numberEnd = string.find(c, "%d+")

      local amount = string.sub(c, numberStart, numberEnd)
      local color = string.sub(c, numberEnd+2)

      draw[color] = amount
    end

    -- add the draw the the draws table of this game (line)
    table.insert(draws, draw)
  end

  if checkIfPossible(draws, limits) then
    sumOfPossibleGames = sumOfPossibleGames + gameId
  end

  local powerNeeded = getLowestPossibleCubesPower(draws)
  print("Lowest possible power: " .. powerNeeded)
  sumOfPower = sumOfPower + powerNeeded
  
  print("#draws: " .. #draws)
  print("----------------------------------------------------")
end

print("")
print("Sum of impossible games IDs: " .. sumOfPossibleGames)
print("Sum of power: " .. sumOfPower)