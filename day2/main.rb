# frozen_string_literal: true

games = File.open('./input.txt').each_with_object({}) do |line, acc|
  key = /^Game\s([0-9]+):/.match(line)[1]
  rest = /^Game\s[0-9]+:(.*)/.match(line)[1]
  picks = rest.split(';').map do |pick|
    pick.split(',').map do |dice|
      dice.split(' ')
    end
  end
  acc[key] = picks
  acc
end

constraints = { red: 12, green: 13, blue: 14 }

one = games.keys.reduce(0) do |sum, game_id|
  possible = true
  games[game_id].each do |pick|
    pick.each do |dice|
      next unless constraints.keys.include?(dice[1].to_sym)

      possible = false if dice[0].to_i > constraints[dice[1].to_sym]
    end
  end
  possible == true ? sum + game_id.to_i : sum
end

p one

two = games.keys.reduce(0) do |sum, game_id|
  required = { red: 0, green: 0, blue: 0 }
  games[game_id].each do |pick|
    pick.each do |dice|
      required[dice[1].to_sym] = dice[0].to_i if dice[0].to_i > required[dice[1].to_sym]
    end
  end
  game_power = required.values.reduce(1) { |power, value| power * value }
  sum + game_power
end

p two
