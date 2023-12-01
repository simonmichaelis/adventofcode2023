local file = io.open("data.txt", "r")
local sum = 0

local digits = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}
local digitStrings = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
local allDigits = {}

for key, value in pairs(digits) do
	table.insert(allDigits, value)
end

for key, value in pairs (digitStrings) do
	table.insert(allDigits, value)
end


function toInteger(String)
	local returnValue = nil

	for index, value in ipairs(digitStrings) do
		if String == value then
			return index
		end
	end

	return String
end


for line in file:lines() do
	local reversedLine = string.reverse(line)

	local firstDigit
	local lastDigit

	local firstDigitPos = #line + 1
	local lastDigitPos = #line +1

	for index, digitString in ipairs(allDigits) do
		-- search from the start of the line for the first digit in the line
		local startPos, endPos =  string.find(line, digitString)
		if startPos ~= nil and startPos < firstDigitPos then
			firstDigitPos = startPos
			firstDigit = toInteger(digitString)
		end

		-- search from the end of the line for the last digit in the line
		reversedString = string.reverse(digitString)
		startPos, endPos = string.find(reversedLine, reversedString)
		if startPos ~= nil and startPos < lastDigitPos then
			lastDigitPos = startPos
			lastDigit = toInteger(digitString)
		end
	end

	sum = sum + tonumber(firstDigit..lastDigit)
end

print("Summe aller Kalibrationswerte: " .. sum)
