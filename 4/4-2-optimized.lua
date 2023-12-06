file = io.open("input.txt", "r")

local stack = {}

local counter = 1
for line in file:lines() do
  local pos1, pos2 = string.find(line, ": ")
  local gameContent = string.sub(line, pos2 + 1)

  local pos2, pos3 = string.find(gameContent, " | ")
  local winners = string.sub(gameContent, 1, pos2 - 1)
  local myNumbers = string.sub(gameContent, pos3 + 1)

  local cardPoints = 0

  for number in string.gmatch(myNumbers, "%d+") do
    for winner in string.gmatch(winners, "%d+") do
      if number == winner then
        cardPoints = cardPoints + 1
      end
    end
  end

  table.insert(stack, { id = counter, points = cardPoints})
  counter = counter + 1
end

local originalAmountOfCards = counter


for index, card in ipairs(stack) do
  for i = card.id + 1, card.id + card.points, 1 do
    if i <= originalAmountOfCards then
      table.insert(stack, stack[i])
    end
  end
end

print("---------------------------------------")
print("Cards in stack: " .. #stack)