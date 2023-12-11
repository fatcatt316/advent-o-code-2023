module Scratchcard
  extend self

  def run(filepath = 'test_input.txt')
    point_sum = File.readlines(filepath).map do |line|
      winning_numbers, my_numbers = line.split(':').last.split('|')
      matches = winning_numbers.split.intersection(my_numbers.chomp.split)
      2 ** (matches.size - 1) if matches.any?
    end.compact.sum

    puts point_sum
  end

  def run2(filepath = 'test_input.txt')
    card_stats = populate_card_stats(filepath)

    # card_stats = {
    #   1: {match_count: 3, copy_count: 0}
    # }
    card_stats.keys.sort.each do |card_num|
      number_to_add_to_each_card = card_stats[card_num][:copy_count]

      (card_num+1..card_stats[card_num][:match_count]+card_num).each do |card_num_to_add_to|
        next unless card_stats[card_num_to_add_to]

        card_stats[card_num_to_add_to][:copy_count] += number_to_add_to_each_card
      end
    end

    puts card_stats.sum { |_card_num, stats| stats[:copy_count] }
  end

  # card_stats = {
  #   1: {match_count: 3, copy_count: 0}
  # ...
  # }
  private def populate_card_stats(filepath)
    card_stats = {}
    File.readlines(filepath).each do |line|
      card_number, numbers = line.split(':')
      card_number = card_number.scan(/\d+/).first.to_i
      winning_numbers, my_numbers = numbers.split('|')
      matches = winning_numbers.split.intersection(my_numbers.chomp.split)

      card_stats[card_number] = {match_count: matches.size, copy_count: 1}
    end

    card_stats
  end
end

puts 'Should be 13'
Scratchcard.run

Scratchcard.run('input.txt')

puts 'Should be 30'
Scratchcard.run2

Scratchcard.run2('input.txt')
