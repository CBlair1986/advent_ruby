# frozen_string_literal: true

input = File.read('/Users/cblair1986/Documents/adventofcode/2021/day2.txt').lines.map(&:split).map do |a, b|
  [a.to_sym, b.to_i]
end

## Sub processes the command list given by the input
class Sub
  def initialize
    @position = 0
    @aim = 0
    @depth = 0
  end

  def process1(com)
    command, amount = com
    case command
    when :forward then @position += amount
    when :up then @depth -= amount
    when :down then @depth += amount
    else raise ArgumentError
    end
  end

  def process2(com)
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
  s.process1 com
end

puts "Part 1: #{s.result}"

s = Sub.new

input.each do |com|
  s.process2 com
end

puts "Part 2: #{s.result}"
