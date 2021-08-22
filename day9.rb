# frozen_string_literal: true

# Part 1

# Split the input into lines and map to_i over them to convert to numbers
input = File.read('input/day9.txt').lines.map(&:to_i)

# Takes a list of numbers and then maintains the logic needed to check the rules of the challenge.
class Checker
  def initialize(preamble)
    @list = preamble
    refresh
  end

  def refresh
    @set = Set.new(@list)
  end

  def find_target_in_set(num)
    result = -1
    @set.each do |n|
      target = num - n
      result = n if @set.member? target
    end
    result
  end

  def shift_list(num)
    @list.shift
    @list.push(num)
    refresh
  end

  def next(num)
    check = find_target_in_set(num)
    shift_list(num)
    check.positive?
  end
end

c = Checker.new(input.shift(25))

input.map! do |num|
  [c.next(num), num]
end

input.filter! { |(is_sum, _num)| !is_sum }

puts "Part 1: #{input.dig(0, 1)}"
