# frozen_string_literal: true

input = File.readlines('input/day03.txt').map(&:strip)

# s: String
def make_sack(sack)
  half = sack.length / 2
  [sack[0..half], sack[half..sack.length]]
end

pp(input.map do |sack|
  make_sack(sack)
end)
