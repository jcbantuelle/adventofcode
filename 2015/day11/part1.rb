require 'pp'

alphabet = %w(a b c d e f g h j k m n p q r s t u v w x y z)

password = 'cqjxjnds'

def valid_password(password)
  doubles = []
  has_straight = false
  password.each_char.to_a.each_with_index { |letter, index|
    second_letter = password[index+1]
    doubles.push letter if letter == second_letter
    third_letter = password[index+2]
    has_straight = true if third_letter && letter.ord+1 == second_letter.ord && letter.ord+2 == third_letter.ord
    return true if has_straight && doubles.uniq.length > 1
  }
  return false
end

while !valid_password(password) do
  letters = password.each_char.to_a.reverse
  letter_index = 0
  loop do
    alpha_index = alphabet.find_index(letters[letter_index])
    alpha_index = alpha_index == 22 ? 0 : alpha_index + 1
    letters[letter_index] = alphabet[alpha_index]
    break unless alpha_index == 0
    letter_index += 1
  end
  password = letters.reverse.join('')
end

pp password
