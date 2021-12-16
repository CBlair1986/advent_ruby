# frozen_string_literal: true

input = File.readlines('input/day11.txt').map(&:strip)
# input = "L.LL.LL.LL
# LLLLLLL.LL
# L.L.L..L..
# LLLL.LL.LL
# L.LL.LL.LL
# L.LLLLL.LL
# ..L.L.....
# LLLLLLLLLL
# L.LLLLLL.L
# L.LLLLL.LL
# ".lines.map(&:strip)

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

  def to_s
    { open: 'L',
      closed: '.',
      taken: '#' }[@state]
  end
end

# Field captures the required behavior for running the life simulation.
class Field
  attr_accessor :field, :changed

  def initialize(value)
    @field = []
    value.each_with_index do |line, idx|
      @field[idx] = []
      parse_line line, idx
    end

    @height = @field.count
    @width = @field[0].count
    @changed = true
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
    locations = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
    locations.each do |(y, x)|
      next if out_of_bounds(idx + y, jdx + x)

      cell = @field[y + idx][x + jdx]
      result.push(cell)
    end
    result
  end

  def out_of_bounds(idx, jdx)
    idx >= @height || idx.negative? || jdx >= @width || jdx.negative?
  end

  def neighbors_by_ray(idx, jdx)
    result = []
    directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
    directions.each do |dir|
      cell = ray(idx, jdx, dir)
      result.push cell
    end
    result
  end

  def ray(idx, jdx, direction); end

  def empty_neighbors(idx, jdx)
    neighbors(idx, jdx).select(&:open?)
  end

  def filled_neighbors(idx, jdx)
    neighbors(idx, jdx).select(&:taken?)
  end

  def occupied
    @field.flatten.select(&:taken?).count
  end

  def toggle(cell, filled_neighbors)
    return Cell.open if filled_neighbors >= 4 && cell.taken?
    return Cell.taken if filled_neighbors.zero? && cell.open?

    cell
  end

  def step
    @changed = false
    new_field = Marshal.load(Marshal.dump(@field))

    @height.times do |i|
      @width.times do |j|
        seat = @field[i][j]
        new_field[i][j] = toggle(seat, filled_neighbors(i, j).count)
      end
    end

    @changed = true unless @field.join == new_field.join

    @field = new_field
  end

  def inspect
    @field.map(&:join).join "\n"
  end
end

f = Field.new input

pp f

while f.changed
  f.step
  pp f
  puts f.occupied
end

p f.occupied # => 2178
