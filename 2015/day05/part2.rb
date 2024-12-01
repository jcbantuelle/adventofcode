require 'pp'

def repeat_pair(text)
  text.each_char.to_a.each_with_index do |letter, index|
    if text[index+1]
      pair = "#{letter}#{text[index+1]}"
      new_text  = text.slice(index+2, text.length)
      return true if new_text.include?(pair)
    end
  end
  return false
end

def has_double_letter(text)
  text.each_char.to_a.each_with_index do |letter, index|
    return true if text[index+2] && letter == text[index+2]
  end
  return false
end

texts = []

File.foreach('input.txt') do |line|
  texts.push(line.chomp)
end

pp texts.select { |text|
  repeat_pair(text) && has_double_letter(text)
}.length
