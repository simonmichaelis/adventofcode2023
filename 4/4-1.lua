file = io.open("input.txt", "r")

local totalPoints = 0

for line in file:lines() do
  local pos1, pos2 = string.find(line, ": ")
  local gameContent = string.sub(line, pos2 + 1)

  local pos2, pos3 = string.find(gameContent, " | ")
  local winners = string.sub(gameContent, 1, pos2 - 1)
  local myNumbers = string.sub(gameContent, pos3 + 1)

  print("---------------------------------------")
  print(line)
  print("Winners: " .. winners)
  print("My picks: " .. myNumbers)

  local myWinners = {}
  local cardPoints = 0

  for number in string.gmatch(myNumbers, "%d+") do
    for winner in string.gmatch(winners, "%d+") do
      if number == winner then
        table.insert(myWinners, number)

        if cardPoints == 0 then
          cardPoints = 1
        else
          cardPoints = cardPoints * 2
        end
      end
    end
  end

  print("Hits: " .. table.concat(myWinners, " "))
  print("Points: " .. cardPoints)

  totalPoints = totalPoints + cardPoints

end

print("---------------------------------------")
print("Total points: " .. totalPoints)