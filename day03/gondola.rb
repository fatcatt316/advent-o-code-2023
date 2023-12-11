module Gondola
  extend self

  def run(filepath = 'test_input.txt')
    schematic = File.readlines(filepath)

    part_number_sum = 0
    schematic.each_with_index do |row, row_num|
      current_number = nil

      (0...row.size).each do |col|

        # if current char is a digit
        if row[col] =~ /\d/
          current_number = "#{current_number}#{row[col]}"

          # if at end of row, time to check for symbols
          if row[col+1].nil?
            if adjacent_to_symbol?(schematic, row_num, col - current_number.size, col-1)
              part_number_sum += current_number.to_i
            end
            current_number = nil
          end
        else
          # just finished building a number, time to check for symbols
          if current_number
            if adjacent_to_symbol?(schematic, row_num, col - current_number.size, col-1)
              part_number_sum += current_number.to_i
            end
            current_number = nil
          end
        end
      end
    end
    puts part_number_sum
  end

  def gear_ratio(filepath = 'test_input.txt')
    schematic = File.readlines(filepath)

    gear_ratio_sum = 0
    schematic.each_with_index do |row, row_num|
      (0...row.size).each do |col|

        # if current char is a gear
        if row[col] =~ /\*/
          adjacent_numbers = find_adjacent_numbers(schematic, row_num, col)

          if adjacent_numbers.size == 2
            gear_ratio_sum += adjacent_numbers.inject(:*)
          end
        end
      end
    end
    puts gear_ratio_sum
  end

  private def find_adjacent_numbers(schematic, row, col)
    col_start = [col-1, 0].max
    min_row = [row-1, 0].max

    adjacent_numbers = []

    (min_row..row+1).each do |row_num|
      next unless schematic[row_num] && schematic[row_num][col_start..col+1] =~ /\d/

      processed_number = false
      (col_start..col+1).each do |col|
        if schematic[row_num][col] =~ /\d/
          # if haven't already found this number...
          unless processed_number
            adjacent_numbers << build_number(schematic[row_num], col)
            processed_number = true
          end
        else
          processed_number = false
        end
      end
    end

    adjacent_numbers
  end

  private def build_number(row, index)
    cur_number = nil
    this_number = false
    (0..row.size).each do |col|
      this_number = true if col == index # we're in the number that we need to return!

      if row[col] =~ /\d/
        cur_number ||= ''
        cur_number << row[col]
      else
        return cur_number.to_i if this_number
        cur_number = nil
      end
    end
  end

  private def adjacent_to_symbol?(schematic, row, col_start, col_end)
    col_start = [col_start-1, 0].max
    min_row = [row-1, 0].max

    (min_row..row+1).each do |row_num|
      return true if schematic[row_num] && schematic[row_num][col_start..col_end+1].chomp =~ /[^\d\.]/
    end
    false
  end
end

puts 'Should be 4361'
Gondola.run

puts 'Should be _'
Gondola.run('input.txt')

puts 'Should be 467835'
Gondola.gear_ratio

puts 'Should be _'
Gondola.gear_ratio('input.txt')
