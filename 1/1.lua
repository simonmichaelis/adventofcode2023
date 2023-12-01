local file = io.open("data.txt", "r")

local sum = 0

for line in file:lines() do
	local digits = {}

	for char in string.gmatch(line, "%d") do
		table.insert(digits, char)
	end

	local calibrationValue = digits[1] .. digits[#digits]

	sum = sum + calibrationValue
end

print(sum)
