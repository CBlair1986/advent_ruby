# frozen_string_literal: true

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

pp g

puts "Part 1: #{groups_sum(g)}"
