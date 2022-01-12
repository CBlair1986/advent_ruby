# frozen_string_literal: true

input = File.read('/Users/cblair1986/Documents/adventofcode/2021/day9.txt').lines.map do |line|
  line.strip.chars.map(&:to_i)
end

## Handles the heightmapping
class Cell
  attr_accessor :height, :north, :east, :south, :west, :neighbors

  def initialize(height, north: nil, east: nil, south: nil, west: nil)
    @height = height
    @north = north
    @east = east
    @south = south
    @west = west
    @neighbors = [north, east, south, west].compact
  end

  def lowest?
    # p(@neighbors.map(&:height), @height)
    @neighbors.map { |neighbor| neighbor.height > @height }.all?
  end

  def risk_level
    @height + 1
  end

  def to_s
    @height.to_s
  end

  def inspect
    to_s
  end
end

sea_floor = []

input.each do |row|
  band = []
  row.each do |item|
    band.push(Cell.new(item))
  end
  sea_floor.push(band)
end

x_upper = sea_floor[0].length
y_upper = sea_floor.length

sea_floor.each_with_index do |row, ydx|
  row.each_with_index do |cell, xdx|
    # if xdx and ydx are at a bound, prevent that link from happening, otherwise link the current cell to it's neighbors
    cell.north = sea_floor.dig(ydx - 1, xdx) unless (ydx - 1).negative?
    cell.south = sea_floor.dig(ydx + 1, xdx) unless (ydx + 1) >= y_upper
    cell.west = sea_floor.dig(ydx, xdx - 1) unless (xdx - 1).negative?
    cell.east = sea_floor.dig(ydx, xdx + 1) unless (xdx + 1) >= x_upper
    cell.neighbors = [cell.north, cell.east, cell.south, cell.west].compact
  end
end

lowest_cells = sea_floor.flatten.filter(&:lowest?)

total_risk = lowest_cells.map(&:risk_level).sum

puts "Part 1: #{total_risk}"

counts = []

lowest_cells.each do |cell|
  stack = [cell]
  seen = []
  count = 0

  until stack.empty?
    current = stack.shift
    seen.push current
    count += 1
    current.neighbors.each do |adjacent|
      if (adjacent.height < 9) && !seen.include?(adjacent)
        stack.push(adjacent)
        seen.push(adjacent)
      end
    end
  end
  counts.push count
end

puts "Part 2: #{counts.sort.reverse.take(3).reduce(&:*)}"
