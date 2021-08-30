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
class Node
  def initialize(name)
    @name = name
    @children = []
  end

  # This should get us a 'trail' of nodes to the one we're looking for.
  def find(name)
    return this if name == @name

    children = @children.select { |child| child.find(name) }
    [this, children]
  end

  def add_child(name)
    @children.append(Node.new(name))
  end

  def add_child_under(parent, name)
    return add_child(name) if @name == parent
    return false if @children.empty?

    @children.map { |child| child.add_child_under(parent, name) }
  end
end

part_two = input.clone

n = Node.new(part_two[0])

part_two.each do |num|
  children = part_two.select { |i| (1..3).cover?(i - num) }
  children.each do |child|
    n.add_child_under(num, child)
  end
end

pp n
