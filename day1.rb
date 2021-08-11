# Day 1

# Part 1
# Find the two numbers that sum to 2020 and multiply them to get the answer

# Read in the input file
input = File.read("input/day1.txt")

# Transform the string into lines

lines = input.lines()

numbers = lines.map(&:to_i)

# What's a good way to pair up the numbers?

pairs = []
current = 0
current_num = 0

nums = numbers.clone

while nums.length > 0
    current_num = nums.pop
    nums.each do |n|
        pairs += [[current_num + n, current_num, n]]
    end
end

# Pairs is populated with every pair and their sum, now we need to filter it down
target = []

pairs.each do |p|
    if p[0] == 2020
        target.append p
    end
end

# Take the first match here:

t = target.first

# Then print the match and the product of the two matched numbers

pp t, t[1] * t[2]

# So that's pretty easy to do, but I'm positive that there's an even easier way using collections...

# The better way (21 lines vs 6):

input = File.read("input/day1.txt").lines.map &:to_i

target = []

input.combination(2) do |c|
    target.append c if c[0] + c[1] == 2020
end

pp target.first.reduce :*

# Part 2

# Find the three numbers that sum to 2020 and return their product

