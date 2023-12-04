# frozen_string_literal: true

### Level 1 ###
one = File.open('./input.txt').map do |line|
  winning_numbers = /^Card\s+[0-9]+:\s+((\d+\s+)+)\|/.match(line)[1].strip.split.map(&:to_i)
  my_numbers = /\|\s+((\d+\s+)+)/.match(line)[1].strip.split.map(&:to_i)

  wins = 0
  value = 0
  my_numbers.each do |my_number|
    next unless winning_numbers.include?(my_number)

    if wins.zero?
      wins += 1
      value = 1
    else
      value *= 2
    end
  end
  value
end
p one.sum

### Level 2 ###
def nb_wins(card)
  winning_numbers = /^Card\s+[0-9]+:\s+((\d+\s+)+)\|/.match(card)[1].strip.split.map(&:to_i)
  my_numbers = /\|\s+((\d+\s+)+)/.match(card)[1].strip.split.map(&:to_i)

  my_numbers.reduce(0) do |wins, my_number|
    wins += 1 if winning_numbers.include?(my_number)
    wins
  end
end

def pick_cards(cards, card_id = 1)
  return cards if card_id > cards.length

  wins = cards[card_id.to_s][:wins]
  new_cards = cards.dup

  cards[card_id.to_s][:count].times do
    (1..wins).each do |win|
      new_cards[(card_id + win).to_s][:count] += 1
    end
  end
  pick_cards(new_cards, card_id + 1)
end

# { card_id: {count:, wins: } }
cards_stats = File.open('./input.txt').each_with_object({}) do |card, cards|
  card_id = /^Card\s+([0-9]+):/.match(card)[1]
  cards[card_id] = { count: 1, wins: nb_wins(card) }
end

picked_cards = pick_cards(cards_stats)
picked_cards_nb = picked_cards.values.reduce(0) do |sum, card|
  sum + card[:count]
end
p picked_cards_nb
