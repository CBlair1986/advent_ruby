# frozen_string_literal: true

input = File.read('input/day3.txt').lines.map(&:strip)

freqs = []

input.each do |line|
  line.chars.each_with_index do |c, i|
    freqs[i] ||= [0, 0]
    freqs[i][c.to_i] += 1
  end
end

gamma = []
epsilon = []

freqs.each do |a, b|
  if a > b
    # 0 more than 1
    gamma.push 0
    epsilon.push 1
  else
    gamma.push 1
    epsilon.push 0
  end
end

puts "Part 1: #{gamma.join.to_i(2) * epsilon.join.to_i(2)}"

oxy_candidates = input.clone.map(&:chars)

co_candidates = input.clone.map(&:chars)

(0...12).each do |idx|
  oxy_digits = oxy_candidates.map { |line| line[idx] }
  co_digits = co_candidates.map { |line| line[idx] }

  oxy_digit = '0'
  co_digit = '1'

  oxy_digit = '1' if oxy_digits.count('1') >= oxy_digits.count('0')
  co_digit = '0' if co_digits.count('1') >= co_digits.count('0')

  oxy_candidates = oxy_candidates.filter { |line| line[idx] == oxy_digit } if oxy_candidates.count > 1
  co_candidates = co_candidates.filter { |line| line[idx] == co_digit } if co_candidates.count > 1
end

puts "Part 2: #{oxy_candidates.first.join.to_i(2) * co_candidates.first.join.to_i(2)}"
