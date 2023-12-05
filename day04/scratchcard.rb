require 'pry'
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
    point_sum = File.readlines(filepath).map do |line|
      winning_numbers, my_numbers = line.split(':').last.split('|')
      matches = winning_numbers.split.intersection(my_numbers.chomp.split)
      2 ** (matches.size - 1) if matches.any?
    end.compact.sum

    puts point_sum
  end




end

puts 'Should be 13'
Scratchcard.run

puts 'Should be 18653'
Scratchcard.run('input.txt')

puts 'Should be 30'
Scratchcard.run2
