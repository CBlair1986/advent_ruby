# frozen_string_literal: true

input = File.read('input/day4.txt')

chunks = input.split("\n\n").map(&:lines)

pp chunks
