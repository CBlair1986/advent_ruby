# frozen_string_literal: true

input = File.read('input/day8.txt').lines.map { |line| line.split('|') }

left_sides = input.map(&:first)
left_sides_symbols = left_sides.map { |line| line.split.map { |word| word.chars.sort.join } }
right_sides = input.map(&:last)
right_sides_symbols = right_sides.map { |line| line.split.map { |word| word.chars.sort.join } }

# part1 = right_sides.map { |line| line.split.filter { |word| [2, 3, 4, 7].include? word.length }.length }
#                    .reduce(&:+)
part1 = right_sides_symbols.map { |words| words.filter { |word| [2, 3, 4, 7].include? word.length }.length }
                           .reduce(&:+)

puts "Part 1: #{part1}"
puts left_sides_symbols, right_sides_symbols
