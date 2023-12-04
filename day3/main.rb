# frozen_string_literal: true

matrix = File.open('./input.txt').map do |line|
  line.chomp.split('').map { |char| char == '.' ? '' : char }
end

# coordinates of matches for a position and a regex
# [[i, j], [k, l]]
def adjacent(matrix, regex, i, j)
  matches = []
  matches << [i, j + 1] if regex.match?(matrix[i][j + 1]) && j < matrix[i].length - 1
  matches << [i, j - 1] if regex.match?(matrix[i][j - 1]) && j.positive?
  if i < matrix.length - 1
    matches << [i + 1, j] if regex.match?(matrix[i + 1][j])
    matches << [i + 1, j + 1] if regex.match?(matrix[i + 1][j + 1]) && j < matrix[i].length - 1
    matches << [i + 1, j - 1] if regex.match?(matrix[i + 1][j - 1]) && j.positive?
  end
  if i.positive?
    matches << [i - 1, j] if regex.match?(matrix[i - 1][j])
    matches << [i - 1, j - 1] if regex.match?(matrix[i - 1][j - 1]) && j.positive?
    matches << [i - 1, j + 1] if regex.match?(matrix[i - 1][j + 1]) && j < matrix[i].length - 1
  end
  matches
end

def adjacent_symbol(matrix, i, j)
  adjacent(matrix, /[^0-9]/, i, j)
end

def adjacent_gear(matrix, i, j)
  adjacent(matrix, /\*/, i, j)
end

def number?(matrix, i, j)
  /[0-9]/.match?(matrix[i][j])
end

### Level 1 ###
parts = []
(0..matrix.length - 1).each do |i|
  potential_match = ''
  is_part = false
  (0..matrix[i].length - 1).each do |j|
    is_number = number?(matrix, i, j)
    potential_match += matrix[i][j] if is_number
    adjacents = adjacent_symbol(matrix, i, j)

    is_part = true if is_number && !adjacents.empty?
    next unless potential_match && (is_number != true || j == matrix[i].length - 1)

    parts << potential_match if is_part
    potential_match = ''
    is_part = false
  end
end

real_parts = parts.map(&:to_i)
p real_parts.sum

### Level 2 ###
gear_parts = []
(0..matrix.length - 1).each do |i|
  potential_match = ''
  is_gear_part = false
  adjacent_gears = []
  (0..matrix[i].length - 1).each do |j|
    is_number = number?(matrix, i, j)
    adjacents = adjacent_gear(matrix, i, j)

    potential_match += matrix[i][j] if is_number
    adjacent_gears << adjacents unless adjacents.empty?
    is_gear_part = true if is_number && !adjacents.empty?

    next unless potential_match && (is_number != true || j == matrix[i].length - 1)

    gear_parts << { match: potential_match, gears: adjacent_gears.flatten(1).uniq } if is_gear_part

    potential_match = ''
    is_gear_part = false
    adjacent_gears = []
  end
end

gears = {}
gear_parts.each_with_index do |gear_part, i|
  gear_part[:gears].each do |gear|
    (gears["#{gear[0]},#{gear[1]}"] ||= []) << gear_parts[i][:match].to_i
  end
end

filtered_gears = {}
gears.each_key do |key|
  filtered_gears[key] = gears[key] if gears[key].length == 2
end

powers = filtered_gears.values.map do |value|
  value[0] * value[1]
end
p powers.sum
