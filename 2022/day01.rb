# frozen_string_literal: true

input = File.read('input/day01.txt').strip

groups = input.split("\n\n")

split_groups = groups.map do |group|
  group.lines.map(&:strip).map(&:to_i).sum
end.sort

pp split_groups.reverse.first
pp split_groups.reverse.take(3).sum
