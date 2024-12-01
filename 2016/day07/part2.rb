require 'pp'

addresses = []

File.foreach('input.txt') do |line|
  addresses.push(line.chomp)
end

valid_addresses = 0
addresses.each { |address|
  hyper = false
  inside = []
  outside = []
  address.each_char.to_a.each_with_index do |letter,index|
    if letter == '['
      hyper = true
      next
    end
    if letter == ']'
      hyper = false
      next
    end
    if hyper
      check = letter == address[index+2] && letter != address[index+1]
      inside.push("#{letter}#{address[index+1]}") if check
    else
      check = letter == address[index+2] && letter != address[index+1]
      outside.push("#{letter}#{address[index+1]}") if check
    end
  end
  valid_addresses += 1 if inside.any?{ |pair|
    outside.include?("#{pair[1]}#{pair[0]}")
  }
}

pp valid_addresses
