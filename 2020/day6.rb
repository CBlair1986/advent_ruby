# frozen_string_literal: true

require 'set'

input = File.read('input/day6.txt')

# Part 1

def groups(str)
  # Assume str is groups of letters, separated by a blank line
  str.split("\n\n").map(&:split)
end

g = groups(input)

def group_count(group)
  sets = group.map { |g| Set.new(g.chars) }
  union = sets.reduce(Set.new, &:union)

  union.count
end

def groups_sum(groups)
  total = 0
  groups.each do |group|
    total += group_count(group)
  end
  total
end

puts "Part 1: #{groups_sum(g)}"

# Part 2

# Should be just a simple change here

def group_count2(group)
  sets = group.map { |g| Set.new(g.chars) }
  intersection = sets.reduce(&:intersection)
  intersection.count
end

def groups_sum2(groups)
  total = 0
  groups.each do |group|
    total += group_count2(group)
  end
  total
end

puts "Part 2: #{groups_sum2(g)}"
