# frozen_string_literal: true

# --- Day 5: Supply Stacks ---

# The expedition can depart as soon as the final supplies have been unloaded
# from the ships. Supplies are stored in stacks of marked crates, but because
# the needed supplies are buried under many other crates, the crates need to
# be rearranged.

# The ship has a giant cargo crane capable of moving crates between stacks. To
# ensure none of the crates get crushed or fall over, the crane operator will
# rearrange them in a series of carefully-planned steps. After the crates are
# rearranged, the desired crates will be at the top of each stack.

# The Elves don't want to interrupt the crane operator during this delicate
# procedure, but they forgot to ask her which crate will end up where, and
# they want to be ready to unload them as soon as possible so they can
# embark.

# They do, however, have a drawing of the starting stacks of crates and the
# rearrangement procedure (your puzzle input). For example:

#     [D]
# [N] [C]
# [Z] [M] [P]
#  1   2   3

# move 1 from 2 to 1
# move 3 from 1 to 3
# move 2 from 2 to 1
# move 1 from 1 to 2

# In this example, there are three stacks of crates. Stack 1 contains two
# crates: crate Z is on the bottom, and crate N is on top. Stack 2 contains
# three crates; from bottom to top, they are crates M, C, and D. Finally,
# stack 3 contains a single crate, P.

# Then, the rearrangement procedure is given. In each step of the procedure, a
# quantity of crates is moved from one stack to a different stack. In the
# first step of the above rearrangement procedure, one crate is moved from
# stack 2 to stack 1, resulting in this configuration:

# [D]
# [N] [C]
# [Z] [M] [P]
#  1   2   3

# In the second step, three crates are moved from stack 1 to stack 3. Crates
# are moved one at a time, so the first crate to be moved (D) ends up below
# the second and third crates:

#        [Z]
#        [N]
#    [C] [D]
#    [M] [P]
# 1   2   3

# Then, both crates are moved from stack 2 to stack 1. Again, because crates
# are moved one at a time, crate C ends up below crate M:

#         [Z]
#         [N]
# [M]     [D]
# [C]     [P]
#  1   2   3

# Finally, one crate is moved from stack 1 to stack 2:

#         [Z]
#         [N]
#         [D]
# [C] [M] [P]
#  1   2   3

# The Elves just need to know which crate will end up on top of each stack; in
# this example, the top crates are C in stack 1, M in stack 2, and Z in stack
# 3, so you should combine these together and give the Elves the message
# CMZ.

# After the rearrangement procedure completes, what crate ends up on top of
# each stack?

#### Part 1

# What are we talking about right now?

input = File.readlines('input/day05.txt')

stacks_section = (input.take_while { |line| line != "\n" })
                 .to_a
                 .map(&:chars)
                 .transpose
                 .map(&:reverse)
                 .filter do |line|
  line[0] != ' ' && line[0] != "\n"
end
                 .map(&:join)
                 .map(&:strip)

moves_section = (input.drop_while do |line|
  line != "\n"
end).to_a.drop(1)

Move = Struct.new(:amount, :from, :to)

def parse_move(line)
  parts = line.match(/move (?<amount>\d+) from (?<from>\d+) to (?<to>\d+)/)
  Move.new(parts[:amount].to_i, parts[:from], parts[:to])
end

moves = moves_section.map do |move_line|
  parse_move(move_line)
end

## Contains the bit and pieces of the alg.
class Stacker
  attr_accessor :stacks

  def initialize(stacks_lines)
    @stacks = {}
    stacks_lines.each do |line|
      chars = line.chars
      first, *rest = chars
      @stacks[first] = rest
    end
  end

  def eval_move(move)
    target = @stacks[move.from].pop(move.amount).reverse
    @stacks[move.to].push(*target)
  end

  def show_top_crates
    @stacks.map { |_k, v| v.last }
  end
end

s = Stacker.new stacks_section

moves.each do |move|
  s.eval_move(move)
end

puts "Part 1: #{s.show_top_crates.join}"

# Stacker2 does the same thing but different
class Stacker2 < Stacker
  def eval_move(move)
    target = @stacks[move.from].pop(move.amount)
    @stacks[move.to].push(*target)
  end
end

s2 = Stacker2.new stacks_section

moves.each do |move|
  s2.eval_move(move)
end

puts "Part 2: #{s2.show_top_crates.join}"
