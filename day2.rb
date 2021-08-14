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

parse_results1 = input.lines.map do |line|
  ts = tokens(line)
  (min, max), rest = parse_min_max(ts)
  character, rest = parse_character(rest)
  {
    min: min.to_i,
    max: max.to_i,
    char: character,
    pass: rest[0]
  }
end

def validate1(min:, max:, char:, pass:)
  x = pass.count(char)
  min <= x && x <= max
end

valid_passwords = parse_results1.select do |p|
  validate1(**p)
end

puts "Part 1 count: #{valid_passwords.length}"

# Part 2
input = File.read('input/day2.txt')

def parse_positions(tokens)
  first = tokens.shift
  [first.split('-'), tokens]
end

parse_results2 = input.lines.map do |line|
  ts = tokens(line)
  (pos1, pos2), rest = parse_positions(ts)
  char, rest = parse_character(rest)
  {
    pos1: pos1.to_i,
    pos2: pos2.to_i,
    char: char,
    pass: rest[0]
  }
end

def charat(pos, str)
  str[pos - 1]
end

def validate2(pos1:, pos2:, char:, pass:)
  [charat(pos1, pass), charat(pos2, pass)].count(char) == 1
end

valid_passwords2 = parse_results2.select do |p|
  validate2(**p)
end

puts "Part 2 count: #{valid_passwords2.length}"
