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

  def run(filepath = 'test_input.txt')
    regex = Regexp.new('(?=(' + STR_TO_DIGIT.keys.join('|') + '))')

    sum = File.readlines(filepath).map do |line|
      digits_to_number(line.scan(regex).flatten)
    end.sum

    puts sum
  end

  private def digits_to_number(digits)
    if digits.size < 2
      "#{STR_TO_DIGIT[digits.first]}#{STR_TO_DIGIT[digits.first]}".to_i
    else
      "#{STR_TO_DIGIT[digits.first]}#{STR_TO_DIGIT[digits.last]}".to_i
    end
  end
end

puts "\nShould be 142"
Calibrator.run('test_input.txt')

puts "\nShould be 281"
Calibrator.run('test_input_part_2.txt')

Calibrator.run('input.txt')
