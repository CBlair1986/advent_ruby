# frozen_string_literal: true

input = File.read('input/day4.txt')

chunks = input.split("\n\n").map(&:lines).map do |chunk|
  c = {}
  chunk.map(&:strip).join(' ').split.each do |part|
    p1, p2 = part.split(':')
    c[p1.to_sym] = p2
  end
  c
end

# chunks now contains hashes of each entry, which will be convenient.

# Part 1
chunks.select! do |chunk|
  if chunk.count == 8
    true
  elsif chunk.count == 7 && !chunk[:cid]
    true
  else
    false
  end
end

puts "Part 1: #{chunks.count}"

# Part 2

# Requires data validation
