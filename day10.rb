# frozen_string_literal: true

input = File.read('input/day10.txt').lines.map(&:to_i)

# Looks like we're daisy-chaining adaptors. Input is a list of them.
# We need to use all the adaptors, then count the number of 1-jolt differences and the number of 3-jolt differences, before finally multiplying them together.
