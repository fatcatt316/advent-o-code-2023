module Calibrator
  extend self

  STR_TO_DIGIT = {
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9,
    '1' => 1,
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
  }

  REGEX = Regexp.new('(?=(' + STR_TO_DIGIT.keys.join('|') + '))')

  def run(filepath = 'test_input.txt')
    sum = File.readlines(filepath).map do |line|
      digits = line.scan(REGEX).flatten
      "#{STR_TO_DIGIT[digits.first]}#{STR_TO_DIGIT[digits.last]}".to_i
    end.sum

    puts sum
  end
end

puts "\nShould be 142"
Calibrator.run('test_input.txt')

puts "\nShould be 281"
Calibrator.run('test_input_part_2.txt')

Calibrator.run('input.txt')
