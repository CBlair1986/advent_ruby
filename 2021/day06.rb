# frozen_string_literal: true

# fish cycles

input = File.read("input/day6.txt").split(",").map(&:to_i)

80.times do
  zeroes = input.filter(&:zero?)
  input.map! do |n|
    if n.zero?
      7
    else
      n
    end
  end
  input.map!(&:pred)
  zeroes.map! { 8 }
  input += zeroes
end

puts "Part 1: #{input.count}"

input = File.read("input/day6.txt").split(",").map(&:to_i)

# # Doing it naively like this doesn't work, it just runs out of memory.
# 256.times do
#   zeroes = input.filter(&:zero?)
#   input.map! do |n|
#     if n.zero?
#       7
#     else
#       n
#     end
#   end
#   input.map!(&:pred)
#   zeroes.map! { 8 }
#   input += zeroes
# end

# Likely I could do something where I keep track of each fish in the input, how many fish those would have spawned, and
# perform some calculations after the fact.

# Like, a fish on 1 would really be a fish at age 5, and at age 7 that fish produces another fish, then every 7 after.
# The produced fish wait for 9 days, then join the 7-day cycle.

# Study each type of fish

# 9.times do |num|
#   fish = [num]

#   256.times do |iteration|
#     zeroes = fish.filter(&:zero?)
#     fish.map! do |n|
#       if n.zero?
#         7
#       else
#         n
#       end
#     end
#     fish.map!(&:pred)
#     zeroes.map! { 8 }
#     fish += zeroes
#     puts "At #{iteration}: #{fish.count}" if (iteration % 10).zero?
#   end

#   puts "One fish at #{num}: #{fish.count}"
# end

# This doesn't work either, just a single fish ends up overflowing and taking forever, lol

# Saw this on reddit, add the fish to an array and wrap the numbers around when they get to the zeroth spot.

fish = [0] * 9

input.each do |num|
  fish[num] += 1
end

256.times do |day|
  zero_fish = fish.shift
  fish.push zero_fish
  fish[7] += fish[0] unless day == 255
end

puts "Part 2: #{fish.reduce(&:+)}"
