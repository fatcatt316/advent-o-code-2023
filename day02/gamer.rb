module Gamer
  extend self

  CUBES = {
    'blue' => 14,
    'green' => 13,
    'red' => 12
  }

  def run(filepath = 'test_input.txt')
    id_sum = File.readlines(filepath).map do |line|
      id, sets = line.split(':')
      next unless sets.split(';').all? { |set| possible_set?(set) }
      id.match(/\d+/)[0].to_i
    end.compact.sum

    puts id_sum
  end

  def run2(filepath = 'test_input.txt')
    power_sum = File.readlines(filepath).sum do |line|
      sets = line.split(':').last
      power(sets)
    end

    puts power_sum
  end

  private def possible_set?(set)
    CUBES.all? do |color, available_count|
      match = set.match(/(\d+) #{color}/)
      match.nil? || match[1].to_i <= available_count
    end
  end

  private def power(sets)
    max_color_counts = Hash.new(0)

    sets.split(';').each do |set|
      CUBES.keys.each do |color|
        match = set.match(/(\d+) #{color}/)
        next unless match

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
