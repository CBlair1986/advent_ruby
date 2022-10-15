# frozen_string_literal: true

# here it would make sense to use a 2d array, but if we use a hashmap instead
# we don't have to mess with as much stuff

class Position
	attr_accessor :x, :y 
	def initialize(start_x, start_y)
		@x = start_x
		@y = start_y
	end

	def move_up
		@y -= 1
	end

	def move_down
		@y += 1
	end

	def move_left
		@x -= 1
	end

	def move_right
		@x += 1
	end

	def parse_move(c)
		case c
		when '^' then move_up
		when '>' then move_right
		when 'v' then move_down
		when '<' then move_left
		end
	end

	def to_s
		[@x, @y].join(', ')
	end
end

$santa_pos = Position.new(0, 0)

visited = Hash.new(0)

visited[$santa_pos.to_s] += 1

input = File.read('input/day03.txt')
            .chars
            .each do |c|
            	$santa_pos.parse_move(c)
            	visited[$santa_pos.to_s] += 1
            end

puts "Part 1: we visited #{visited.count} houses"

visited = Hash.new(0)

$santa_pos = Position.new(0, 0)

$robot_santa_pos = Position.new(0, 0)

$santa_move = true

input = File.read('input/day03.txt')
            .chars
            .each do |c|
            	if $santa_move
            		$santa_pos.parse_move(c)
            		visited[$santa_pos.to_s] += 1
            	else
            		$robot_santa_pos.parse_move(c)
            		visited[$robot_santa_pos.to_s] += 1
            	end
            	$santa_move = !$santa_move
            end

puts "Part 2: we visited #{visited.count} houses"