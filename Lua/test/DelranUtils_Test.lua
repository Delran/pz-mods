require("Mock")
require("Delran_Utils")

local test_string = "string_one;string_two;string_three"

local table = DelranUtils.Split(test_string)

for index, string in ipairs(table) do
    print(table[index])
end
