# frozen_string_literal: true

# Part 1

input = File.read('input/day01.txt').chars()

level = 0

input.each do |c|
	if c == '(' then
		level += 1
	else
		level -= 1
	end
end

puts level