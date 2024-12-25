# First bad bit is z06

# x05 AND y05 -> tcn
# * y06 AND x06 -> z06

# crm AND sss -> jsd
# tcn OR jsd -> swj

# * swj XOR rjv -> hwk

# First Swap
# z06 <=> hwk

# Second bad bit is z25

# y24 AND x24 -> spw
# y25 AND x25 -> tnt

# wpg AND mhr -> ptr
# ptr OR spw -> nbs

# nbs XOR tnt -> z25

# * y25 XOR x25 -> qmd

# Second Swap
# tnt <=> qmd

# Third bad bit is z31

# y30 AND x30 -> rtq
# y31 XOR x31 -> vkh

# rmb AND rpt -> kcn
# rtq OR kcn -> dtq

# vkh XOR dtq -> hpc

# Third Swap
# hpc <=> z31

# Fourth bad bit is z37

# x36 AND y36 -> ksr
# x37 XOR y37 -> vqv

# gqc XOR vqv -> cgr

# gqc AND vqv -> z37

# Fourth Swap
# z37 <=> cgr

require 'pp'

# z06 <=> hwk
# tnt <=> qmd
# hpc <=> z31
# z37 <=> cgr
pp %w(z06 hwk tnt qmd hpc z31 z37 cgr).sort.join(',')

exit

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

x = gates.keys.select{|k| k[0] == 'x'}.sort.reverse.reduce('') { |number, key|
  number + gates[key].to_s
}.to_i(2)

y = gates.keys.select{|k| k[0] == 'y'}.sort.reverse.reduce('') { |number, key|
  number + gates[key].to_s
}.to_i(2)

pp "x: #{x}"
pp "y: #{y}"

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

z = gates.keys.select{|k| k[0] == 'z'}.sort.reverse.reduce('') { |number, key|
  number + gates[key].to_s
}.to_i(2)

pp "right z: #{x+y}"
pp "wrong z: #{z}"
pp (x+y).to_s(2)
pp (z).to_s(2)
