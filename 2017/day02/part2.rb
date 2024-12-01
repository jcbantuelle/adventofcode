require 'pp'

rows = []

File.foreach('input.txt') do |line|
  rows.push(line.chomp.split(' ').map(&:to_i))
end

total = 0

rows.each { |row|
  found_digit = false
  row.each_with_index do |digit, index|
    row.each_with_index do |other_digit, other_index|
      next if index == other_index
      if digit % other_digit == 0
        total += digit / other_digit
        found_digit = true
        break
      end
    end
    break if found_digit
  end
}

pp total
