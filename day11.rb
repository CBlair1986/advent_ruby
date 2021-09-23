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
    locations = ([-1, 0, 1] * 2).permutation(2).uniq.to_a
    locations.delete [0, 0]
    locations.each do |(y, x)|
      line = @field[y + idx]
      next if line.nil?

      cell = @field[y + idx][x + jdx]
      result.push(cell) unless cell.nil?
    end
    result
  end

  def empty_neighbors(idx, jdx)
    neighbors(idx, jdx).select(&:open?)
  end

  def filled_neighbors(idx, jdx)
    neighbors(idx, jdx).select(&:taken?)
  end

  def occupied
    @field.flatten.select(&:taken?).count
  end

  def step
    @changed = false
    new_field = Marshal.load(Marshal.dump(@field))

    @height.times do |i|
      @width.times do |j|
        seat = @field[i][j]
        new_field[i][j] = Cell.open if seat.taken? && (filled_neighbors(i, j).count >= 4)
        new_field[i][j] = Cell.taken if seat.open? && filled_neighbors(i, j).count.zero?
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

p f.occupied
