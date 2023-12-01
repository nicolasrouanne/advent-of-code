# frozen_string_literal: true

one = File.open('./input.txt').reduce(0) do |sum, line|
  first = /([0-9])/.match(line)
  last = /[0-9](?!.*[0-9])/.match(line)
  sum +  Integer(first[0] + last[0])
end

p one

two = File.open('./input.txt').reduce(0) do |sum, line|
  letter_digits = { one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9 }
  regex = "([0-9]|#{letter_digits.keys.join('|')})"

  scan = line.scan(/(?=#{regex})/).flatten
  first = scan.first
  last = scan.last
  first_integer = begin
    Integer(first)
  rescue StandardError
    letter_digits[first.to_sym]
  end
  last_integer = begin
    Integer(last)
  rescue StandardError
    letter_digits[last.to_sym]
  end
  sum + "#{first_integer}#{last_integer}".to_i
end

p two
