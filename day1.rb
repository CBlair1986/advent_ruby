# Day 1

# Part 1
puts "Part 1"
# Find the two numbers that sum to 2020 and multiply them to get the answer

# Read in the input file
input = File.read("input/day1.txt")

# Transform the string into lines

lines = input.lines()

numbers = lines.map(&:to_i)

# What's a good way to pair up the numbers?

pairs = []
current_num = 0

nums = numbers.clone

while nums.length > 0
    current_num = nums.pop
    nums.each do |n|
        pairs += [[current_num + n, current_num, n]]
    end
end

# This whole thing above could be turned into a function

def comb(ary)
    ps = []
    ns = ary.clone
    cn = 0
    while ns.length > 0
        cn = ns.pop
        ns.each do |n|
            ps.append [cn, n]
        end
    end
    return ps
end

input = File.read("input/day1.txt").lines.map &:to_i

combs = comb(input).map do |c|
    [c[0]+c[1]]+c
end

pp combs == pairs


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
puts "Part 2"

# Find the three numbers that sum to 2020 and return their product

# The hard way, just to figure it out algorithmically
# Basically, just append each number to the pairs made with the rest of the list

input = File.read("input/day1.txt")
lines = input.lines
numbers = lines.map &:to_i

nums = numbers.clone
triples = []

while nums.length > 0
    num = nums.pop
    rest = nums.clone
    while rest.length > 0
        n = rest.pop
        rest.each do |r|
            triples.append [num, n, r]
        end
    end
end

# Now triples should have a collection of all the triples present in the set of numbers, without any number being duplicated

triples.map do | (x,y,z) |
    puts x*y*z if x+y+z == 2020
end

# And again, that's pretty easy to do, but...

# The better way (21 lines vs 6):

input = File.read("input/day1.txt").lines.map &:to_i

target = []

input.combination(3) do |c|
    target.append c if c[0] + c[1] + c[2] == 2020
end

pp target.first.reduce :*