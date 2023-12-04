require 'pry'
module Gondola
  extend self

  # SYMBOLS = %w(* ? + # $)

  def run(filepath = 'test_input.txt')
    schematic = File.readlines(filepath)
     
    part_number_sum = 0
    schematic.each_with_index do |row, row_num|
      current_number = nil

      (0..row.size).each do |col|

        # if current chart is a digit
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

  private def adjacent_to_symbol?(schematic, row, col_start, col_end)
    col_start = [col_start-1, 0].max
    min_row = [row-1, 0].max

    (min_row..row+1).each do |row_num|
      return true if schematic[row_num] && schematic[row_num][col_start..col_end+1] =~ /[^\d\.]/
    end
    false
  end
end

puts "Should be 4361"
Gondola.run

Gondola.run('input.txt')