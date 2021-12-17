# frozen_string_literal: true

input = File.read('input/day3.txt').lines

def parse_bitstring(s)
  s.to_i(2)
end

puts(input.map { |s| [s, parse_bitstring(s)] })
