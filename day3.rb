# frozen_string_literal: true

# Just a test change

# File input
input = File.read('input/day3.txt')

# Part 1
class Position
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def shift(dx, dy)
    p = clone

    p.x += dx
    p.y += dy
    p
  end

  def shift!(dx, dy)
    @x += dx
    @y += dy
  end

  def self.zero
    new(0, 0)
  end
end

# Map takes care of the addressing of locations on the map, handling the wrapping behavior defined in the challenge.
class Map
  attr_accessor :field

  def initialize(instr)
    @field = instr.lines.map(&:strip).map(&:chars)
  end

  def at(pos)
    # pos is a Position
    # We need to wrap around the edge of the map, so we'll take x mod width
    if pos.y <= height
      @field.dig(pos.y, pos.x % width)
    else
      false
    end
  end

  def width
    @field[0].length
  end

  def height
    @field.length
  end
end

m = Map.new(input)

dx = 3
dy = 1

p = Position.new(0, 0)

count = 0

while terrain = m.at(p)
  count += 1 if terrain == '#'
  p.shift!(dx, dy)
end

puts "Part 1: #{count}"

# Part 2

deltas = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
]

total_count = 1

deltas.each do |(dx, dy)|
  count = 0

  m = Map.new(input)
  p = Position.zero

  while terrain = m.at(p)
    count += 1 if terrain == '#'
    p.shift!(dx, dy)
  end

  total_count *= count
end

puts "Part 2: #{total_count}"
