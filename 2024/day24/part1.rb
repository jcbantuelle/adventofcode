require 'pp'

gates = {}
pairs = []

values = true
File.open('input.txt').map(&:chomp).each { |line|
  if line.empty?
    values = false 
  elsif values
    gate, value = line.split(': ')
    gates[gate] = value.to_i
  else
    g1, logic, g2, _, g3 = line.split(' ')

    pairs << [g1, g2, logic, g3]
  end
}

loop do
  break if pairs.empty?
  pairs, evaluations = pairs.partition{|g1, g2, logic, g3| gates[g1].nil? || gates[g2].nil?}
  evaluations.each do |g1, g2, logic, g3|
    if logic == 'AND'
      gates[g3] = gates[g1] & gates[g2]
    elsif logic == 'OR'
      gates[g3] = gates[g1] | gates[g2]
    elsif logic == 'XOR'
      gates[g3] = gates[g1] ^ gates[g2]
    end
  end
end

pp gates.keys.select{|k| k[0] == 'z'}.sort.reverse.reduce('') { |number, key|
  number + gates[key].to_s
}.to_i(2)
