# frozen_string_literal: true

input = File.read('input/day4.txt').split("\n\n")

sequence = input.shift

class Board
  def initialize(grid)
    @board = []
    @filled = []
    grid.lines.each do |line|
      @board.push line.split.map(&:to_i)
      @filled.push(line.split.map { |_| false })
    end
  end

  def fill_number(n)
    @board.each_with_index do |line, i|
      line.each_with_index do |space, j|
        @filled[i][j] = true if space == n
      end
    end
    self
  end

  def completed?
    transposed_filled = @filled.transpose
    @filled.any?(&:all?) || transposed_filled.any?(&:all?)
  end

  def unmarked
    mask = @filled.flatten
    nums = @board.flatten
    mask.zip(nums).reject(&:first).map { |item| item[1] }
  end

  def unmarked_sum
    unmarked.sum
  end
end

boards = input.map { |section| Board.new(section) }

finished = []
winning_number = []

sequence.split(',').map(&:to_i).each do |n|
  boards.each { |b| b.fill_number n }
  next unless boards.any?(&:completed?)

  finished.push boards.filter(&:completed?).first
  boards = boards.reject(&:completed?)
  winning_number.push n
end

pp finished, winning_number, finished.first.unmarked_sum * winning_number.first,
   finished.last.unmarked_sum * winning_number.last
