# frozen_string_literal: true

def extract_area(s)
	parts = s.split("x")
	unless parts.count > 0
		return
	end

	parts = parts.map(&:to_i).sort
	l, w, h = parts
	(2*l*w) + (2*w*h) + (2*h*l) + (l*w)
end

def extract_ribbon_length(s)
	parts = s.split("x")
	unless parts.count > 0
		return
	end

	parts = parts.map(&:to_i).sort
	l, w, h = parts
	(l+l+w+w) + (l*w*h)
end

input = File.read('input/day02.txt')
			.lines()

puts "Part 1: We need #{input.map { |line| extract_area line }.reduce(&:+)} square feet of wrapping paper."
puts "Part 2: We need #{input.map { |line| extract_ribbon_length line }.reduce(&:+)} feet of ribbon."