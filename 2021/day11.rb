# frozen_string_literal: true

require 'pry'

input = File.read('/Users/cblair1986/Documents/adventofcode/2021/day11.txt')
            .lines
            .map(&:strip)
            .map(&:chars)
            .map { |chars| chars.map(&:to_i) }

## Grid will handle the grid, obviously
class Grid
  attr_accessor :grid, :height, :width

  def initialize(grid)
    @grid = grid
    @height = grid.length
    @width = grid.first.length
  end

  def at(xloc, yloc)
    return nil if xloc.negative? || xloc >= width || yloc.negative? || yloc >= height

    @grid[yloc][xloc]
  end

  def ortho_neighbors(xloc, yloc)
    # Returns the orthographic (n,s,e,w) neighbors
    locs = [[xloc, yloc - 1],
            [xloc, yloc + 1],
            [xloc - 1, yloc],
            [xloc + 1, yloc]]

    locs
      .map { |x, y| at(x, y) }
      .compact
  end

  def diag_neighbors(xloc, yloc)
    # Returns the diagonal (ne, nw, se, sw) neighbors
    locs = [[xloc + 1, yloc - 1],
            [xloc + 1, yloc + 1],
            [xloc - 1, yloc - 1],
            [xloc - 1, yloc + 1]]

    locs
      .map { |x, y| at(x, y) }
      .compact
  end

  def neighbors(xloc, yloc)
    # Returns both the diagonal and orthographic neighbors
    ortho = ortho_neighbors(xloc, yloc)
    diag = diag_neighbors(xloc, yloc)
    ortho + diag
  end

  def inspect
    @grid.map(&:join).join("\n")
  end

  def to_s
    @grid.map(&:join).join("\n")
  end
end

## Cells get linked together to facilitate the energy mechanics
class Cell
  attr_accessor :neighbors, :flashed, :energy

  def initialize(energy)
    @energy = energy
    @flashed = false
    @neighbors = []
  end

  def tick
    @energy += 1
    return unless @energy > 9 && !@flashed

    @flashed = true
    @neighbors.each(&:tick)
  end

  def reset
    return unless @flashed

    @flashed = false
    @energy = 0
  end

  def inspect
    return @energy.to_s unless @flashed

    '*'
  end

  def to_s
    return @energy.to_s unless @flashed

    '*'
  end
end

g = Grid.new(input)

grid = []

(0...g.width).each do |i|
  row = []
  (0...g.height).each do |j|
    row.push Cell.new(g.at(j, i))
  end
  grid.push row
end

grid = Grid.new(grid)

g = grid.grid

g.each_with_index do |row, idx|
  row.each_with_index do |cell, jdx|
    ns = grid.neighbors(jdx, idx)
    cell.neighbors = ns
  end
end

flashes = 0

100.times do
  g.each do |row|
    row.each(&:tick)
  end

  # count flashes
  flashes += g.flatten
              .filter(&:flashed)
              .length

  g.each do |row|
    row.each(&:reset)
  end
end

puts "Part 1: #{flashes}"

g = Grid.new(input)

grid = []

(0...g.width).each do |i|
  row = []
  (0...g.height).each do |j|
    row.push Cell.new(g.at(j, i))
  end
  grid.push row
end

grid = Grid.new(grid)

g = grid.grid

g.each_with_index do |row, idx|
  row.each_with_index do |cell, jdx|
    ns = grid.neighbors(jdx, idx)
    cell.neighbors = ns
  end
end

target = g.flatten.count

1000.times do |n|
  g.each do |row|
    row.each(&:tick)
  end

  # count flashes
  if g.flatten.filter(&:flashed).count == target
    puts "Part 2: #{n + 1}"
    break
  end

  g.each do |row|
    row.each(&:reset)
  end
end
