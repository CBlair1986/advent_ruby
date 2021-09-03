# frozen_string_literal: true

# Part 1

input = File.read('input/day10.txt').lines.map(&:to_i)
input << 0
input << input.max + 3

input = input.sort

lagged_input = input.clone
lagged_input.shift

zipped_inputs = input.zip(lagged_input)
zipped_inputs.pop # This should be pairs of inputs now.

one_gaps = zipped_inputs.select { |(one, two)| two - one == 1 }
three_gaps = zipped_inputs.select { |(one, two)| two - one == 3 }

# Looks like we're daisy-chaining adaptors. Input is a list of them.
# We need to use all the adaptors, then count the number of 1-jolt differences and the number of 3-jolt differences,
# before finally multiplying them together.

# pp input, one_gaps, one_gaps.count, three_gaps, three_gaps.count

value = one_gaps.count * three_gaps.count

puts "Part 1: #{value}"

# Part 2

# We need to count how many different ways we can 'bridge' the gaps between the adaptors. I could end up doing an
# imperative looping thing where I make a tree of all the accessible nodes from the current node, and iterate until I
# hit the 'end' node, but that sounds pretty painful.

# Node is a utility class that encodes the structure of a tree.
# class Node
#   attr_accessor :value, :children

#   def initialize(value)
#     @value = value
#     @children = []
#   end

#   def to_a
#     [@value, @children.map(&:to_a)]
#   end

#   def count
#     return 1 if @children.empty?

#     @children.map(&:count).reduce(&:+)
#   end
# end

part_two = input.clone

# n = Node.new(part_two[0])

# front = [n]

# part_two.each do |num|
#   children = part_two.select { |i| (1..3).cover?(i - num) }
#   front.each do |parent|
#     next unless parent.value == num

#     cs = children.map { |c| Node.new(c) }
#     parent.children = cs
#     front += cs
#     front.delete parent
#   end
#   puts front.count
# end

# pp n.count

# I could just use a single hash, and have each n be the key for the n+1..n+3 children

# Let's try a graph

# DirectedGraph provides an API to interact with a graph structure.
# class DirectedGraph
#   def initialize
#     @vertices = Set.new
#     @edges = Set.new
#   end

#   def add_vertex(value)
#     @vertices.add value
#   end

#   def add_edge(value, another_value)
#     add_vertex value
#     add_vertex another_value
#     @edges.add [value, another_value]
#   end

#   def get_connections(value)
#     @edges.select { |a, _b| a == value }
#   end
# end

# g = DirectedGraph.new

# input.each do |n|
#   children = input.select { |num| (1..3).cover? num - n }
#   children.each do |m|
#     g.add_edge n, m
#   end
# end

# start = 0
# target = input.max

# def follow_connections(value, target, g)
#   return 1 if value == target

#   connections = g.get_connections(value).map { |_a, b| b }
#   connections.map { |v| follow_connections v, target, g }.reduce(&:+)
# end

# puts follow_connections(start, target, g)

p(part_two.each_cons(2).map { |a, b| b - a }.chunk { |n| n == 3 }.reject { |a, _b| a })
