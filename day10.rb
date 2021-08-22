# frozen_string_literal: true

# Part 1

input = File.read('input/day10.txt').lines.map(&:to_i).sort
lagged_input = input.clone
lagged_input.shift

zipped_inputs = input.zip(lagged_input)
zipped_inputs.pop # This should be pairs of inputs now.

one_gaps = zipped_inputs.select { |(one, two)| two - one == 1 }
three_gaps = zipped_inputs.select { |(one, two)| two - one == 3 }

# Looks like we're daisy-chaining adaptors. Input is a list of them.
# We need to use all the adaptors, then count the number of 1-jolt differences and the number of 3-jolt differences,
# before finally multiplying them together.

# pp input, one_gaps, one_gaps.count, three_gaps, three_gaps.count

puts "Part 1: #{(one_gaps.count + 1) * (three_gaps.count + 1)}"

# Part 2

# We have to count the different arrangements for connection between 0 and 3 + max.
