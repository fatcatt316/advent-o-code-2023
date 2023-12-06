module Racer
  extend self

  def run(part, filepath = 'test_input.txt')
    times, distances = get_times_and_distances(filepath, part)

    ways_to_win = times.size.times.map do |race_index|
      mix_or_max_time_revving_up(times[race_index], distances[race_index], :max) -
      mix_or_max_time_revving_up(times[race_index], distances[race_index], :min) +
      1
    end.inject(:*)

    puts ways_to_win
  end

  private def get_times_and_distances(filepath, part)
    if part == 1
      File.readlines(filepath).map { |line| line.split[1..-1].map(&:to_i) }
    else
      File.readlines(filepath).map { |line| [line.scan(/\d/).join.to_i] }
    end
  end

  private def mix_or_max_time_revving_up(total_time_available, min_required_distance, min_or_max = :min)
    enumerator(total_time_available, min_or_max).each do |time_spent_revving_up|
      mm_per_ms = time_spent_revving_up
      total_distance = (total_time_available - time_spent_revving_up) * mm_per_ms
      return time_spent_revving_up if total_distance > min_required_distance
    end
  end

  private def enumerator(total_time_available, min_or_max)
    if min_or_max == :min
      1.upto(total_time_available-1)
    else
      (total_time_available-1).downto(1)
    end
  end
end

puts 'Should be 288'
Racer.run(1)

Racer.run(1, 'input.txt')

puts 'Should be 71503'
Racer.run(2)

Racer.run(2, 'input.txt')
