require 'pp'

e_conversions = {}
conversions = {}
medicine = nil

File.foreach('input.txt') do |line|
  line = line.chomp
  if line.include?('=')
    conversion = line.split(' => ').reverse
    if conversion[1] == 'e'
      e_conversions[conversion[0]] = true
    else
      conversions[conversion[0]] = conversion[1]
    end
  else
    medicine = line
  end
end

conversion_lengths = conversions.keys.map(&:length).uniq.sort.reverse
steps = 1

while !e_conversions[medicine] do
  conversion_made = false
  conversion_lengths.each do |conversion_length|
    medicine.each_char.to_a.each_with_index do |letter, index|
      length = index + (conversion_length - 1)
      substitution = conversions[medicine[index..length]]
      if substitution
        medicine[index..length] = substitution
        conversion_made = true
        break
      end
    end
    break if conversion_made
  end
  steps += 1
end

pp steps
