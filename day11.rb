# frozen_string_literal: true

input = File.readlines('input/day11.txt').map(&:strip)

# Cell represents the states that individual cells can be in
class Cell
  def initialize(state)
    @state = state
  end

  def self.open
    Cell.new :open
  end

  def open?
    @state == :open
  end

  def self.closed
    Cell.new :closed
  end

  def closed?
    @state == :closed
  end

  def self.taken
    Cell.new :taken
  end

  def taken?
    @state == :taken
  end

  def inspect
    @state
  end
end

# Field captures the required behavior for running the life simulation.
class Field
  attr_accessor :field

  def initialize(value)
    @field = []
    value.each_with_index do |line, idx|
      @field[idx] = []
      parse_line line, idx
    end
  end

  def parse_line(line, idx)
    line.chars.each_with_index do |char, jdx|
      case char
      when 'L'
        @field[idx][jdx] = Cell.open
      when '.'
        @field[idx][jdx] = Cell.closed
      end
    end
  end

  def neighbors(idx, jdx)
    # Get the neighbors of the given cell location
    result = []
    locations = ([-1, 0, 1] * 2).permutation(2).uniq.to_a
    locations.each do |(y, x)|
      result.push(@field[y + idx][x + jdx])
    end
    result
  end

  def empty_neighbors(idx, jdx)
    neighbors(idx, jdx).select(&:open?)
  end

  def filled_neighbors(idx, jdx)
    neighbors(idx, jdx).select(&:taken?)
  end
end

p Field.new input
