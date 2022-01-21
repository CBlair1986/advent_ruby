# frozen_string_literal: true

input = File.read("input/day1.txt")
            .lines
            .map(&:to_i)
lagged_input = input.clone
lagged_input.shift

part1 = input
  .zip(lagged_input)
  .reject { |i| i.any?(&:nil?) }
  .map { |a, b| b - a }
  .filter(&:positive?)
  .count

puts "Part 1: #{part1}"

double_lagged_input = lagged_input.clone
double_lagged_input.shift

part2_first = input
  .zip(lagged_input, double_lagged_input)
  .reject { |i| i.any?(&:nil?) }
  .map { |a, b, c| a + b + c }

part2_second = part2_first.clone
part2_second.shift

part2 = part2_first.zip(part2_second).reject { |i| i.any?(&:nil?) }.map { |a, b| b - a }.filter(&:positive?).count

puts "Part 2: #{part2}"
