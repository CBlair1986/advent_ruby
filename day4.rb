# frozen_string_literal: true

input = File.read('input/day4.txt')

chunks = input.split("\n\n").map(&:lines).map do |chunk|
  c = {}
  chunk.map(&:strip).join(' ').split.each do |part|
    p1, p2 = part.split(':')
    c[p1.to_sym] = p2
  end
  c
end

# chunks now contains hashes of each entry, which will be convenient.

# Part 1
chunks.select! do |chunk|
  if chunk.count == 8
    true
  elsif chunk.count == 7 && !chunk[:cid]
    true
  else
    false
  end
end

puts "Part 1: #{chunks.count}"

# Part 2

# Requires data validation

RULES = {
  byr: lambda { |str|
    num = str.to_i
    num >= 1920 && num <= 2002
  },
  iyr: lambda { |str|
    num = str.to_i
    num >= 2010 && num <= 2020
  },
  eyr: lambda { |str|
    num = str.to_i
    num >= 2020 && num <= 2030
  },
  hgt: lambda { |str|
    s = str.clone
    units = s.slice!(-2, 2)
    num = s.to_i

    case units
    when 'in'
      num >= 59 && num <= 76
    when 'cm'
      num >= 150 && num <= 193
    else
      false
    end
  },
  hcl: lambda { |str|
    chars = str.chars
    if chars.shift == '#'
      s = chars.join
      s.count('1234567890abcdef') == 6
    else
      false
    end
  },
  ecl: lambda { |str|
    %w[amb blu brn gry grn hzl oth].member? str
  },
  pid: lambda { |str|
    str.count('1234567890') == 9
  },
  cid: lambda { |_str|
    true
  }
}.freeze

REQUIRED = %w[byr iyr eyr hgt hcl ecl pid].map(&:to_sym).freeze

def validate(chunk)
  if REQUIRED.all? { |sym| chunk[sym] }
    results = chunk.map do |(k, v)|
      puts "#{k}, #{v}" unless RULES[k.to_sym][v]
      RULES[k.to_sym][v]
    end

    results.all?
  else
    false
  end
end

num_valid = chunks.select { |chunk| validate(chunk) }.count

puts "Part 2: #{num_valid}"
