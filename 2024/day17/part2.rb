possibilities = [1]
[2,4,1,2,7,5,1,3,4,4,5,5,0,3,3].reverse.each { |o|
  new_possibilities = []
  possibilities.map{|a| a*8}.each do |x|
    x.upto(x+7) do |a|
      calc = ((a % 8) ^ 1 ^ (a / 2**((a % 8) ^ 2)) % 8)
      new_possibilities << a if calc == o
    end
  end
  possibilities = new_possibilities
}
puts possibilities.sort[0]
