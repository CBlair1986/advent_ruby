# frozen_string_literal: true

# File input
input = File.read('input/day2.txt')

puts input

# Part 1

# Parsing passwords:asdf
# The password is presented on the same line as its validator sequence.
# If the given string is "1-9 a: abcde" then it wants to verify that anywhere between one and nine 'a's are present in
# the ending string.

def parse_min_max(str)
  [false, str]
end

# Part 2
