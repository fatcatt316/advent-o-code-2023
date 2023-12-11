require 'pry'
module CamelCard
  extend self

  CARDS_BY_STRENGTH = %w[A K Q J T 9 8 7 6 5 4 3 2]

  HAND_TYPE_STRENGTHS = [
    :five_of_a_kind,
    :four_of_a_kind,
    :full_house,
    :three_of_a_kind,
    :two_pair,
    :one_pair,
    :high_card
  ]

  def run(filepath = 'test_input.txt')
    hands = populate_hands(filepath)
    hands = sort_hands(hands) # add :rank to each card
    binding.pry

    puts hands.sum { |hand| hand[:rank] * hand[:bid] }
  end

  private def calculate_winnings(hands)
    hands.sum do |hand|
      hand.bid * hand.rank
    end
  end

  private def sort_hands(hands) # add :rank to each card
    hands.sort do |a, b|
      comp = (HAND_TYPE_STRENGTHS.index(a[:type]) <=> HAND_TYPE_STRENGTHS.index(b[:type]))
      if comp.zero? # if both cards have same hand type strength
        compare_hand_strengths(a, b)
      else
        comp
      end
    end.reverse.each_with_index do |hand, i|
      hand[:rank] = i+1
    end
  end

  private def compare_hand_strengths(hand1, hand2)
    hand1.each_with_index do |card, i|
      next if hand1[:strengths][i] == hand2[:strengths][i]

      if hand1[:strengths][i] < hand2[:strengths][i]
        return -1
      else
        return 1
      end
    end
    0
  end

  private def populate_hands(filepath)
    point_sum = File.readlines(filepath).map do |line|
      hand, bid = line.split
      cards = hand.chars
      strengths = cards.map { |card| CARDS_BY_STRENGTH.index(card) }.map(&:to_i)

      {
        type: calculate_hand_type(cards),
        cards: cards,
        bid: bid.to_i,
        strengths: strengths
      }
    end
  end

  private def calculate_hand_type(cards)
    HAND_TYPE_STRENGTHS.each do |hand_type|
      return hand_type if send("#{hand_type}?", cards)
    end
  end

  private def five_of_a_kind?(cards)
    cards.uniq.size == 1
  end

  private def four_of_a_kind?(cards)
    cards.uniq.any? do |card|
      cards.count(card) == 4
    end
  end

  private def full_house?(cards)
    cards.uniq.size == 2
  end

  private def three_of_a_kind?(cards)
    cards.uniq.any? do |card|
      cards.count(card) == 3
    end
  end

  private def two_pair?(cards)
    cards.uniq.size == cards.size - 2
  end

  private def one_pair?(cards)
    cards.uniq.size == cards.size - 1
  end

  private def high_card?(cards)
    true
  end
end

# puts 'Should be 6440'
# CamelCard.run

# TOo low: 248453239
CamelCard.run('input.txt')
