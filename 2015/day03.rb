# frozen_string_literal: true

# here it would make sense to use a 2d array, but if we use a hashmap instead
# we don't have to mess with as much stuff

$pos = [0, 0]

def move_up
	x = $pos[0]
	y = $pos[1] - 1
	$pos = [x, y]
end

def move_down
	x = $pos[0]
	y = $pos[1] + 1
	$pos = [x, y]
end

def move_left
	x = $pos[0] - 1
	y = $pos[1]
	$pos = [x, y]
end

def move_right
	x = $pos[0] + 1
	y = $pos[1]
	$pos = [x, y]
end

def parse_move(c)
	case c
	when '^' then move_up
	when '>' then move_right
	when 'v' then move_down
	when '<' then move_left
	end
end

visited = Hash.new(0)

visited[$pos.to_s] += 1

input = File.read('input/day03.txt')
            .chars
            .each do |c|
            	parse_move(c)
            	visited[$pos.to_s] += 1
            end

puts "Part 1: we visited #{visited.count} houses"