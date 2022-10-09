# frozen_string_literal: true

# Part 1

input = File.read('input/day01.txt').chars()

level = 0

position = 1

basement_position = nil

input.each do |c|
	if c == '(' then
		level += 1
	else
		level -= 1
	end

	if level == -1 && basement_position == nil then
		basement_position = position
	end

	position += 1
end

puts "Part 1: We end on level #{level}"
puts "Part 2: We enter the basement at #{basement_position}"
