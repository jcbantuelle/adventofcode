require 'pp'

addresses = []

File.foreach('input.txt') do |line|
  addresses.push(line.chomp)
end

valid_addresses = 0
addresses.each { |address|
  hyper = false
  valid_outside = false
  valid_inside = true
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
      check = letter == address[index+3] && address[index+1] == address[index+2] && letter != address[index+1]
      if check
        valid_inside = false
        break
      end
    else
      check = letter == address[index+3] && address[index+1] == address[index+2] && letter != address[index+1]
      valid_outside = true if check
    end
  end
  valid_addresses += 1 if valid_outside && valid_inside
}

pp valid_addresses
