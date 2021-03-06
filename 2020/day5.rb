# frozen_string_literal: true

# Day 5

# Parsing seat locations
# The plane has 128 rows, 8 columns

input = File.read('input/day5.txt')
tickets = input.lines.map(&:strip)

locations = tickets.map do |ticket|
  t = ticket.clone
  row_string = t.slice!(0, 7)
  col_string = t
  row_num = row_string.chars.map do |c|
    { 'B' => 1,
      'F' => 0 }[c]
  end.join.to_i(2)
  col_num = col_string.chars.map do |c|
    { 'L' => 0,
      'R' => 1 }[c]
  end.join.to_i(2)
  [row_num, col_num, row_num * 8 + col_num]
end

number_of_seats = locations.map { |l| l[2] }.max

puts "Part 1: #{number_of_seats}"

# Part 2
sorted_locations = locations.map { |l| l[2] }.sort

def slices(slice_size, ary)
  results = []
  last_index = ary.length - slice_size
  curr = 0
  while curr < last_index
    results.append ary.slice(curr, slice_size)
    curr += 1
  end
  results
end

def adjacent?((x, y, z))
  x + 1 == y && y + 1 == z
end

s = slices(3, sorted_locations)
non_adjacents = s.reject { |slice| adjacent?(slice) }
a, b = non_adjacents.reduce(&:intersection)

puts "Part 2 #{(a + b) / 2}"
