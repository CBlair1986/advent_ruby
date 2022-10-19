# frozen_string_literal: true

require 'digest'

input = File.read('input/day04.txt').strip

def leading_zeros(s)
  s.chars.take_while {|c| c == '0'}.count
end

def find_number(s)
  salt = 1

  plaintext = s + salt.to_s

  while leading_zeros(Digest::MD5.hexdigest(plaintext)) < 5
    salt += 1
    plaintext = s + salt.to_s
  end
  salt
end

salt = find_number(input)

puts "Part 1: the salt is #{salt}"
