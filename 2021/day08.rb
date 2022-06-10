# frozen_string_literal: true

input = File.read("input/day8.txt").lines.map { |line| line.split("|") }

left_sides = input.map(&:first)
left_sides_symbols = left_sides.map { |line| line.split.map { |word| word.chars.sort.join } }
right_sides = input.map(&:last)
right_sides_symbols = right_sides.map { |line| line.split.map { |word| word.chars.sort.join } }

# part1 = right_sides.map { |line| line.split.filter { |word| [2, 3, 4, 7].include? word.length }.length }
#                    .reduce(&:+)
part1 = right_sides_symbols.map { |words| words.filter { |word| [2, 3, 4, 7].include? word.length }.length }
                           .reduce(&:+)

puts "Part 1: #{part1}"

GROUPS = %w[abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg].map(&:chars).freeze

input = File.read("input/day8.txt").lines

# The layout of a cell is:

#   0:      [1:]      2:       3:      [4:]      5:       6:      [7:]     [8:]      9:
#  aaaa              aaaa     aaaa              aaaa     aaaa     aaaa     aaaa     aaaa
# b    c        c        c        c   b    c   b        b             c   b    c   b    c
# b    c        c        c        c   b    c   b        b             c   b    c   b    c
#                    dddd     dddd     dddd     dddd     dddd              dddd     dddd
# e    f        f   e             f        f        f   e    f        f   e    f        f
# e    f        f   e             f        f        f   e    f        f   e    f        f
#  gggg              gggg     gggg              gggg     gggg              gggg     gggg
#
# with the groups given in the entire line, we get cf + bcdf + acf = abcdf, with the rest in abcdefg, so we just have to
# figure out which ones are e and g. e is contained in zero, two, six, and eight, g is contained in zero, two, three,
# five, six, eight, and nine.

## This is responsible for decoding the lines given to return the right hand result
class LineSegment
  # rubocop:disable all
  def initialize(input_line)
    @left_symbols = input_line.split("|").first.strip.split.map { |word| word.chars.sort }
    @right_symbols = input_line.split("|").last.strip.split.map { |word| word.chars.sort }
    @all_symbols = @left_symbols | @right_symbols
    @one = @all_symbols.filter { |group| group.length == 2 }.first
    @four = @all_symbols.filter { |group| group.length == 4 }.first
    @seven = @all_symbols.filter { |group| group.length == 3 }.first
    @eight = @all_symbols.filter { |group| group.length == 7 }.first

    counts = []

    10.times do
      row = []
      10.times do
        row.push 0
      end
      counts.push row
    end

    GROUPS.each_with_index do |i, idx|
      GROUPS.each_with_index do |j, jdx|
        unioned = i & j
        counts[idx][jdx] = unioned.length
      end
    end

    @decoder = counts.values_at(1, 4, 7, 8).transpose
  end

  def convert_digits
    # Map against one, four, seven, and eight
    template = [@one, @four, @seven, @eight]
    decoded = {}
    @all_symbols.each do |group|
      code = template.map { |t| (t & group).length }
      # find code in decoder
      decoded[group] = @decoder.index(code)
    end
    left_decoded = @left_symbols.map { |group| decoded[group] }
    right_decoded = @right_symbols.map { |group| decoded[group] }
    [left_decoded.join.to_i, right_decoded.join.to_i]
  end

  # rubocop:enable all
end

puts "Part 2: #{input.map { |line| LineSegment.new(line).convert_digits.last }.sum}"
