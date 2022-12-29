# frozen_string_literal: true

input = File.read('input/day02.txt').strip

commands = input.lines.map { |line| line.split(' ').map(&:to_sym) }

score_table_one = {
  "A": {         # W + S
    "X": 3 + 1,  # 3 + 1
    "Y": 6 + 2,  # 6 + 2
    "Z": 0 + 3   # 0 + 3
  },
  "B": {
    "X": 0 + 1,  # 0 + 1
    "Y": 3 + 2,  # 3 + 2
    "Z": 6 + 3   # 6 + 3
  },
  "C": {
    "X": 6 + 1,  # 6 + 1
    "Y": 0 + 2,  # 0 + 2
    "Z": 3 + 3   # 3 + 3
  }
}

score_table_two = {
  "A": {         # W + O
    "X": 3 + 0,  # 3 + 0
    "Y": 1 + 3,  # 1 + 3
    "Z": 2 + 6   # 2 + 6
  },
  "B": {
    "X": 1 + 0,  # 1 + 0
    "Y": 2 + 3,  # 2 + 3
    "Z": 3 + 6   # 3 + 6
  },
  "C": {
    "X": 2 + 0,  # 2 + 0
    "Y": 3 + 3,  # 3 + 3
    "Z": 1 + 6   # 1 + 6
  }
}

pp (commands.map do |command|
  score_table_one.fetch(command[0]).fetch(command[1])
end).sum

pp (commands.map do |command|
  score_table_two.fetch(command[0]).fetch(command[1])
end).sum
