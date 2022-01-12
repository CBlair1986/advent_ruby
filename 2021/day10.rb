# frozen_string_literal: true

input = File.read('/Users/cblair1986/Documents/adventofcode/2021/day10.txt').lines.map(&:strip)

# rubocop:disable Metrics/[MethodLength, AbcSize]
def find_mismatch(line)
  opening_delimiters = %w#( [ { <#
  closing_delimiters = %w#) ] } >#
  corrupt_score = [3, 57, 1197, 25_137]
  incomplete_score = [1, 2, 3, 4]

  close_stack = []

  line.chars.each do |char|
    if opening_delimiters.include? char
      char_index = opening_delimiters.index(char)
      matching_closer = closing_delimiters[char_index]
      close_stack.push(matching_closer)
    elsif closing_delimiters.include? char
      char_index = closing_delimiters.index(char)
      # If we are expecting this closer (i.e. it is the top of the close_stack) we just pop
      # Otherwise we'll return the score of the caught symbol
      return [:corrupted, corrupt_score[char_index]] unless close_stack.last == char

      close_stack.pop
    else
      throw "Unrecognized symbol: #{char}"
    end
  end

  # If we make it here, the line isn't corrupted
  # The proper closing string should just the the contents of close_stack
  score = 0
  close_stack.reverse.each do |char|
    amount = incomplete_score[closing_delimiters.index(char)]
    # puts "Got char: #{char} -- #{(score * 5) + amount} = #{score} * 5 + #{amount}"
    score = (score * 5) + amount
  end
  [:incomplete, "#{line} + #{close_stack.reverse.join}", score]
end
# rubocop:enable all

corrupts = input.map { |line| find_mismatch(line) }.filter { |item| item.first == :corrupted }.map(&:last)
puts "Part 1: #{corrupts.reduce(&:+)}"

incompletes = input.map { |line| find_mismatch(line) }.filter { |item| item.first == :incomplete }
puts "Part 2: #{incompletes.map(&:last).sort[incompletes.length / 2]}"
