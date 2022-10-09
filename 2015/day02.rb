# frozen_string_literal: true

def extract_area(s)
	parts = s.split("x")
	unless parts.count > 0
		return
	end

	parts = parts.map(&:to_i).sort
	l, w, h = parts
	2*l*w + 2*w*h + 2*h*l + l*w
end

input = File.read('input/day02.txt')
			.lines()
			.map { |line| extract_area line }

puts input.reduce(&:+)