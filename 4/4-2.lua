file = io.open("input.txt", "r")

local stack = {}

local counter = 1
for line in file:lines() do
  table.insert(stack, { id = counter, content = line})
  counter = counter + 1
end

local originalAmountOfCards = counter

function copyCards(Index, Amount)
  for i = Index + 1, Index + Amount, 1 do
    if i >= originalAmountOfCards then
      -- ...
    else
      --print("copying card " .. i .. "...")
      table.insert(stack, stack[i])
    end
  end
end


for index, card in ipairs(stack) do
  local pos1, pos2 = string.find(card.content, ": ")
  local gameContent = string.sub(card.content, pos2 + 1)

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

  copyCards(card.id, cardPoints)

end

print("---------------------------------------")
print("Cards in stack: " .. #stack)