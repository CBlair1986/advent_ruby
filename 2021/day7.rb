# frozen_string_literal: true

crab_positions = File.read('/Users/cblair1986/Documents/adventofcode/2021/day7.txt').split(',').map(&:to_i)

max_bound = crab_positions.max
min_bound = crab_positions.min

fuel_usage = 0

until min_bound == max_bound
  count_at_min = crab_positions.filter { |crab| crab == min_bound }.count
  count_at_max = crab_positions.filter { |crab| crab == max_bound }.count

  if count_at_min > count_at_max
    # moving max is cheaper
    crab_positions.map! do |crab|
      if crab == max_bound
        crab - 1
      else
        crab
      end
    end
    max_bound -= 1
    fuel_usage += count_at_max
  elsif count_at_max >= count_at_min
    crab_positions.map! do |crab|
      if crab == min_bound
        crab + 1
      else
        crab
      end
    end
    min_bound += 1
    fuel_usage += count_at_min
  end
end
puts "Part 1: used #{fuel_usage} fuel"

crab_positions = File.read('/Users/cblair1986/Documents/adventofcode/2021/day7.txt').split(',').map do |str|
  [str.to_i, str.to_i]
end

max_bound = crab_positions.map(&:last).max
min_bound = crab_positions.map(&:last).min

fuel_usage = 0

def calculate_cost(pair)
  start = pair.first
  current = pair.last

  (current - start).abs + 1
end

until min_bound == max_bound
  cost_at_min = crab_positions
                .filter { |crab| crab.last == min_bound }
                .map { |crab| calculate_cost crab }
                .reduce(&:+)
  cost_at_max = crab_positions
                .filter { |crab| crab.last == max_bound }
                .map { |crab| calculate_cost crab }
                .reduce(&:+)

  if cost_at_min > cost_at_max
    # moving max is cheaper
    crab_positions.map! do |crab|
      if crab.last == max_bound
        [crab.first, crab.last - 1]
      else
        crab
      end
    end
    max_bound -= 1
    fuel_usage += cost_at_max
  elsif cost_at_max >= cost_at_min
    crab_positions.map! do |crab|
      if crab.last == min_bound
        [crab.first, crab.last + 1]
      else
        crab
      end
    end
    min_bound += 1
    fuel_usage += cost_at_min
  end
end
puts "Part 2: used #{fuel_usage} fuel"
