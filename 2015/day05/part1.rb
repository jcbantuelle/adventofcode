require 'pp'

def vowel_count(text)
  count = 0
  vowels = %w{a e i o u}
  text.each_char do |letter|
    count += 1 if vowels.include?(letter)
  end
  return count
end

def has_double_letter(text)
  last_letter = ''
  text.each_char do |letter|
    return true if letter == last_letter
    last_letter = letter
  end
  return false
end

def no_naughty_string(text)
  ['ab', 'cd', 'pq', 'xy'].none? { |string|
    text.include?(string)
  }
end

texts = []

File.foreach('input.txt') do |line|
  texts.push(line.chomp)
end

pp texts.select { |text|
  no_naughty_string(text) && vowel_count(text) > 2 && has_double_letter(text)
}.length
