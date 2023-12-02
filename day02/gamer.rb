require 'pry'
module Gamer
  extend self

  CUBES = {
    'blue' => 14,
    'green' => 13,
    'red' => 12
  }

  def run(filepath = 'test_input.txt')
    id_sum = 0
    File.readlines(filepath).map do |line|
      id, sets = line.split(':')
      next unless sets.split(';').all? { |set| possible_set?(set) }
      id_sum += id.match(/\d+/)[0].to_i
    end

    puts id_sum
  end

  def run2(filepath = 'test_input.txt')
    power_sum = 0
    File.readlines(filepath).map do |line|
      _id, sets = line.split(':')
      power_sum += power(sets)
    end

    puts power_sum
  end

  private def possible_set?(set)
    CUBES.all? do |color, available_count|
      match = set.match(/(\d+) #{color}/)
      match.nil? || match[1].to_i <= available_count
    end
  end

  # 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  private def power(sets)
    max_color_counts = Hash.new(0)

    sets.split(';').each do |set|
      CUBES.keys.each do |color|
        match = set.match(/(\d+) #{color}/)
        next if match.nil?

        max_color_counts[color] = [match[1].to_i, max_color_counts[color]].max
      end
    end

    max_color_counts.values.inject(:*) 
  end
end

puts 'Should be 8'
Gamer.run

puts "\nShould be _"
Gamer.run('input.txt')

puts "\nShould be 2286"
Gamer.run2

puts "\nShould be _"
Gamer.run2('input.txt')