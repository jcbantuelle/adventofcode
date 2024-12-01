require 'pp'

messages = []

File.foreach('input.txt') do |line|
  messages.push(line.chomp)
end

frequencies = []

messages.each do |message|
  message.each_char.to_a.each_with_index do |letter, index|
    frequencies[index] = [] if frequencies[index].nil?
    letter_index = frequencies[index].find_index { |frequency|
      frequency[0] == letter
    }
    if letter_index
      frequencies[index][letter_index][1] += 1
    else
      frequencies[index].push([letter, 1])
    end
  end
end

pp frequencies.map { |frequency|
  frequency.max{ |freq1, freq2|
    freq1[1] <=> freq2[1]
  }[0]
}.join('')
