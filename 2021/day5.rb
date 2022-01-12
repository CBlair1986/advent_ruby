# frozen_string_literal: true

input = File.read('/Users/cblair1986/Documents/adventofcode/2021/day5.txt').lines.map(&:split)

## Has to do with parsing and tracking the state
class LineGrid
  def initialize(x_size, y_size)
    @x_size = x_size
    @y_size = y_size
    @board = []
    @x_size.times do
      row = []
      @y_size.times do
        row.push(0)
      end
      @board.push(row)
    end
  end

  def line(from_x, from_y, to_x, to_y, ignore_diagonals: false)
    if from_x == to_x
      (from_y..to_y).each { |idx| @board[from_x][idx] += 1 } if to_y > from_y
      (to_y..from_y).each { |idx| @board[from_x][idx] += 1 } if from_y > to_y
    elsif from_y == to_y
      (from_x..to_x).each { |idx| @board[idx][from_y] += 1 } if to_x > from_x
      (to_x..from_x).each { |idx| @board[idx][from_y] += 1 } if from_x > to_x
    elsif ignore_diagonals == false
      # Diagonal line
      # There are four options
      # ne, se, sw, nw

      length = (from_x - to_x).abs + 1

      if to_y > from_y && to_x > from_x
        # northeast
        length.times do |idx|
          @board[from_x + idx][from_y + idx] += 1
        end
      elsif from_y > to_y && to_x > from_x
        # southeast
        length.times do |idx|
          @board[from_x + idx][from_y - idx] += 1
        end
      elsif from_y > to_y && from_x > to_x
        # southwest
        length.times do |idx|
          @board[from_x - idx][from_y - idx] += 1
        end
      else
        # northwest
        length.times do |idx|
          @board[from_x - idx][from_y + idx] += 1
        end
      end
    end
  end

  def draw(ary, ignore_diagonals: false)
    from = ary[0]
    to = ary[2]
    from_x, from_y = from.split ','
    to_x, to_y = to.split ','
    line(from_x.to_i, from_y.to_i, to_x.to_i, to_y.to_i, ignore_diagonals: ignore_diagonals)
  end

  def count_overlaps
    @board.flatten.filter { |n| n > 1 }.count
  end

  def to_s
    output = @board.clone
    output.map { |i| i.join '' }.join "\n"
  end
end

# max_x = 0
# max_y = 0

# input.map { |a, _, c| a.split(',').map(&:to_i) + c.split(',').map(&:to_i) }.each do |x1, y1, x2, y2|
#   max_x = x1 if x1 > max_x
#   max_x = x2 if x2 > max_x
#   max_y = y1 if y1 > max_y
#   max_y = y2 if y2 > max_y
# end

# puts max_x, max_y

lg = LineGrid.new(990, 991)

input.each do |line|
  lg.draw(line, ignore_diagonals: true)
end

puts "Part 1: #{lg.count_overlaps}"

lg = LineGrid.new(990, 991)

input.each do |line|
  lg.draw(line, ignore_diagonals: false)
end

puts "Part 2: #{lg.count_overlaps}"
