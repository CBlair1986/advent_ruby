#frozen_string_literal: true

input = File.read('input/day05.txt').lines

def three_vowels?(s)
  s.scan(/[aeiou]/).count >= 3
end

def double_letter?(s)
  s.scan(/(.)\1/).count.positive?
end

def bad_strings?(s)
  %w[ab cd pq xy].map{ |pair|
    s.include? pair
  }.any?
end

def double_pair?(s)
end

def spaced_pair?(s)
end

def nice?(s, part = :one)
  if part == :one
    three_vowels?(s) && double_letter?(s) && !bad_strings?(s)
  else
    double_pair?(s) && spaced_pair?(s)
  end
end

nice_strings_count = input.filter { |s|
  nice? s
}.count

puts "Part 1: there are #{nice_strings_count} nice strings"

nice_strings_count = input.filter { |s|
  nice? s, :two
}.count

puts "Part 2: there are #{nice_strings_count} nice strings"