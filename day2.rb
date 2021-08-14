# frozen_string_literal: true

# File input
input = File.read('input/day2.txt')

# Part 1

# Parsing passwords:asdf
# The password is presented on the same line as its validator sequence.
# If the given string is "1-9 a: abcde" then it wants to verify that anywhere between one and nine 'a's are present in
# the ending string.

def tokens(str)
  str.split
end

def parse_min_max(tokens)
  first = tokens.shift
  x, y = first.split '-'

  [[x, y], tokens]
end

def parse_character(tokens)
  first = tokens.shift
  char = first[0]

  [char, tokens]
end

parse_results = input.lines.map do |line|
  ts = tokens(line)
  min_maxes, rest = parse_min_max(ts)
  min, max = min_maxes
  character, rest = parse_character(rest)
  {
    min: min,
    max: max,
    character: character,
    password: rest[0]
  }
end

pp parse_results
# Part 2
