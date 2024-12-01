require 'pp'

conversions = Array.new
medicine = nil

File.foreach('input.txt') do |line|
  line = line.chomp
  if line.include?('=')
    conversions.push(line.split(' => '))
  else
    medicine = line
  end
end

possibilities = []
medicine.each_char.to_a.each_with_index do |letter, index|
  conversions.each do |conversion|
    length = index + (conversion[0].length - 1)
    if medicine[index..length] == conversion[0]
      possibility = medicine.dup
      possibility[index..length] = conversion[1]
      possibilities.push(possibility)
    end
  end
end

pp possibilities.uniq.length
