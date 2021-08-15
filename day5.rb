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

pp locations.map { |l| l[2] }.max
