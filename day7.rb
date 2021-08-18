# frozen_string_literal: true

input = File.read('input/day7.txt')

# Part 1

# Here I should take advantage of the fact that all the lines have the same format:
# <type of bag> contain <number> <type of bag(s)>[, <number> <type of bag(s)>] etc
# or
# <type of bag> contain no other bags

# I think this will form a tree, and I just need to find all the paths to nodes containing shiny gold bag(s)

# But first, we need to handle the strings we expect to see.

def parse_line(line)
  # We can always assume that splitting on " contain " is OK
  front, back = line.split ' contain '

  # front should contain a string of the form "<type> bags"
  type_of_bag = parse_bag(front)[:bag_type]
  bag_strings = back.split ', '
  bag_contents = bag_strings.map { |str| parse_number_and_bag(str) }
  { bag_type: type_of_bag, bag_quantity: 1, bag_contents: bag_contents }
end

def parse_bag(str)
  # In theory we should just split on " bags" and return the first part of the results..
  front, _back = str.split ' bags'

  # We'll unify on this structure for now...
  { bag_type: front, bag_quantity: 1 }
end

def parse_number_and_bag(str)
  # Assume there is a number as the first word in the string...
  tokens = str.split
  number = tokens.shift
  rest = tokens.join ' '
  front, _back = rest.split ' bag'

  { bag_quantity: number, bag_type: front }
end

pp(input.lines.map(&:strip).map { |line| parse_line line })

# Part 2
