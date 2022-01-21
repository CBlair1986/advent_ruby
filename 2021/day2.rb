# frozen_string_literal: true

input = File.read("input/day2.txt").lines.map(&:split).map do |a, b|
  [a.to_sym, b.to_i]
end

## Sub processes the command list given by the input
class Sub
  def initialize
    @position = 0
    @aim = 0
    @depth = 0
  end

  def process_day_one(com)
    command, amount = com
    case command
    when :forward then @position += amount
    when :up then @depth -= amount
    when :down then @depth += amount
    else raise ArgumentError
    end
  end

  def process_day_two(com)
    command, amount = com
    case command
    when :forward
      @position += amount
      @depth += amount * @aim
    when :up then @aim -= amount
    when :down then @aim += amount
    else raise ArgumentError
    end
  end

  def result
    @position * @depth
  end
end

s = Sub.new

input.each do |com|
  s.process_day_on com
end

puts "Part 1: #{s.result}"

s = Sub.new

input.each do |com|
  s.process_day_two com
end

puts "Part 2: #{s.result}"
