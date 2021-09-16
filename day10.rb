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
class DirectedGraph
  def initialize(input, cover)
    @vertices = Set.new
    @edges = Set.new

    input.each do |n|
      children = input.select(&cover.curry.call(n))
      children.each do |m|
        add_edge n, m
      end
    end
  end

  def add_vertex(value)
    @vertices.add value
  end

  def include?(value)
    @vertices.include? value
  end

  def max
    @vertices.max
  end

  def min
    @vertices.min
  end

  def size
    @vertices.count
  end

  def add_edge(value, another_value)
    add_vertex value
    add_vertex another_value
    @edges.add [value, another_value]
  end

  def get_connections_from(value)
    @edges.select { |a, _b| a == value }
  end

  def get_connections_to(value)
    @edges.select { |_a, b| b == value }
  end

  def inspect
    @edges.to_a.sort
  end
end

COVER_FUNC = ->(n, num) { (1..3).cover? num - n }

graph = DirectedGraph.new(input, COVER_FUNC)

# I should be able to separate the graph into individual graphs, if I just loop through the nodes and "split" each one
# that only has two links...

# DirectedGraphProcessor is going to be doing the heavy lifting here...
class DirectedGraphProcessor
  def initialize(graph)
    @graph = graph
  end

  def flood_fill(from, steps = 1)
    return [] unless @graph.include? from

    visited = []
    edge = []

    visited.unshift from

    connections = @graph.get_connections_from from
    connections.map { |e| e[1] }.each do |e|
      edge.unshift e
    end

    while steps.positive?
      # Iterate through the edge set, testing if any destinations are in visited, and if not, putting them into edge instead.
      current_edge = edge.clone
      edge = []

      current_edge.each do |node|
        next if visited.include? node

        visited.unshift node

        connections = @graph.get_connections_from node
        connections.map { |e| e[1] }.each do |e|
          edge.unshift e
        end
      end
      steps -= 1
    end
    visited
  end

  def partition_graph
    subgraphs = []

    # The thinking here is that through successive flood filling we should be able to determine when we've hit a
    # bottleneck as soon as the next flood fill step only adds one node to the 'visited' nodes.
    old_total = new_total = 0
    starting_node = @graph.min
    graph_end = @graph.max

    until starting_node == graph_end
      chunk = []
      (1..@graph.size).each do |i|
        old_total = new_total
        chunk = flood_fill starting_node, i
        new_total = chunk.count
        break if new_total - old_total == 1
      end
      subgraphs.push chunk
      starting_node = chunk.max
    end
    subgraphs.map { |coll| DirectedGraph.new(coll, COVER_FUNC) }
  end
end

dpg = DirectedGraphProcessor.new graph

subgraphs = dpg.partition_graph

def follow_connections(value, target, graph)
  return 1 if value == target

  connections = graph.get_connections_from(value).map { |(_a, b)| b }
  connections.map { |val| follow_connections val, target, graph }.reduce(&:+)
end

lengths = subgraphs.map do |graph|
  start = graph.min
  target = graph.max

  [graph, follow_connections(start, target, graph)]
end

pp lengths

# puts "Part 2: #{lengths.reduce(&:*)}"
