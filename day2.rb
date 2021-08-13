input = File.read("input/day2.txt")

puts input

# Part 1

# Parsing passwords:
# The password is presented on the same line as its validator sequence.
# If the given string is "1-9 a: abcde" then it wants to verify that anywhere between one and nine 'a's are present in the ending string.

def parse_min_max(str)
	return false, str
end


# Part 2