# frozen_string_literal: true
require 'set'

input = File.readlines('input/day03.txt').map(&:strip)

# s: String
def make_sack(sack)
  sack = sack.strip
  half = sack.length / 2
  [sack[0..(half - 1)], sack[half..sack.length]]
end

def find_similar_item(sack)
  first = Set.new(sack[0].chars)
  second = Set.new(sack[1].chars)

  (first & second).first
end

def lookup_priority(char)
  (('a'..'z').to_a + ('A'..'Z').to_a).find_index(char) + 1
end

pp (input.map do |sack|
  lookup_priority(
    find_similar_item(
      make_sack(sack)
    )
  )
end).sum
