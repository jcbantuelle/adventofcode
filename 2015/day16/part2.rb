require 'pp'

matching = {
  'children' => 3,
  'cats' => 7,
  'samoyeds' => 2,
  'pomeranians' => 3,
  'akitas' => 0,
  'vizslas' => 0,
  'goldfish' => 5,
  'trees' => 3,
  'cars' => 2,
  'perfumes' => 1
}

File.foreach('input.txt') do |line|
  sue = line.chomp.match(/^[A-Za-z]+\s(\d+):\s(.*)$/)
  attributes = sue[2].split(', ').map{|attribute|attribute.split(': ')}.to_h
  the_sue = attributes.map{ |attribute, value|
    if ['cats', 'trees'].include?(attribute)
      matching[attribute] < value.to_i
    elsif ['pomeranians', 'goldfish'].include?(attribute)
      matching[attribute] > value.to_i
    else
      matching[attribute] == value.to_i
    end
  }.all?{|value| value}
  if the_sue
    pp sue[1]
    break
  end
end
