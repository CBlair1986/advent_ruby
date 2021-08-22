# frozen_string_literal: true

input = File.read('input/day8.txt').lines.map(&:strip)

# Part 1

# runs the program given by `listing`
class ProgramRunner
  attr_accessor :logging_enabled

  def initialize(listing)
    @listing = listing
    @pointer = 0
    @eof = listing.count
    @visits = Array.new(@eof, 0)
    @accumulator = 0
    @logging_enabled = false
  end

  # rubocop:disable Metrics
  def step
    return [true, @accumulator] if @pointer == @eof

    current_command, argument = parse_line(@listing[@pointer])
    @visits[@pointer] += 1
    return [false, @accumulator] if @visits[@pointer] > 1

    case current_command
    when 'acc'
      @accumulator += argument.to_i
      @pointer += 1
    when 'jmp'
      @pointer += argument.to_i
    when 'nop'
      @pointer += 1
    else
      raise "unexpected command #{current_command} with argument #{argument}"
    end
    nil
  end
  # rubocop:enable Metrics

  def line
    "Line #{@pointer}: #{@listing[@pointer]}"
  end

  def parse_line(str)
    str.split
  end

  def end_of_file?
    @pointer == @listing.count
  end

  def run
    until s = step
      puts line if @logging_enabled
    end
    s
  end

  def flip_instruction(line_number)
    command, argument = parse_line(@listing[line_number])
    new_command =
      case command
      when 'jmp' then 'nop'
      when 'nop' then 'jmp'
      else command
      end
    @listing[line_number] = new_command + ' ' + argument
  end
end

pr = ProgramRunner.new(input)
# pr.logging_enabled = true

s = pr.run

puts "Part 1: #{s}"

# Part 2

class ProgramRunnerRunner
  def initialize(listing)
    @original = listing

    @program_runners = Array.new(@original.count)

    @program_runners = @program_runners.each_index.map do |i|
      pr = ProgramRunner.new(@original.clone)
      pr.flip_instruction(i)
      pr
    end
  end

  def run
    # run each program, altering one instruction so that it flips from nop to jmp or jmp to nop, without touching the
    # other instructions

    @program_runners.map(&:run)
  end
end

prr = ProgramRunnerRunner.new(input)

results = prr.run

ended = results.select { |(ended, _accumulator)| ended }

puts "Part 2: #{ended[0]}"
