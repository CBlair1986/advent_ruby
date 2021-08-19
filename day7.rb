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

def find_bag_type(bag_type, bags_list)
  # Which ones have a shiny gold?
  container_bags = # There's got to be a better way to do this?!
    select_bags_list(bag_type, bags_list)
  finished_container_bags = Set.new
  until container_bags.empty?
    container_bag_type = container_bags.pop
    container_bags +=
      select_bags_list(container_bag_type, bags_list)
    finished_container_bags << container_bag_type
  end
  finished_container_bags
end

# Returns a list of bags from the given list that contain a bag of the given type
def select_bags_list(bag_type, bags_list)
  bags_list.select { |bag| bag[:bag_contents].map { |b| b[:bag_type] }.member? bag_type }.map { |b| b[:bag_type] }
end

bags_list = input.lines.map(&:strip).map { |line| parse_line line }

part1_count = find_bag_type('shiny gold', bags_list).count
puts "Part 1: #{part1_count}"

# Part 2

# We need to find out the total number of bags that a shiny gold bag needs to contain, which is like the opposite of
# what we did above. We need to find the bags in the shiny gold bag, but also remember their quantities.

def find_nested_bags(bag_type, bags_list)
  target_bag = bags_list.select { |bag| bag[:bag_type] == bag_type }[0]
  # Can I just use recursion?
  unless target_bag.nil?
    if target_bag.key?(:bag_contents)
      contents = target_bag[:bag_contents].map do |b|
        find_nested_bags(b[:bag_type], bags_list)
      end
    end
    [target_bag, contents]
  end
end

pp find_nested_bags('shiny gold', bags_list)
