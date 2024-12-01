require 'pp'

claims = []
fabric = Array.new()
0.upto(999) do |index|
  fabric.push(Array.new(1000, 0))
end

File.foreach('input.txt') do |line|
  claim = line.chomp.match(/#(\d*)\s@\s(\d*),(\d*):\s(\d*)x(\d*)/)
  claims.push(claim.to_a.drop(1).map(&:to_i))
end

claims.each do |claim|
  x_coord = claim[1]
  y_coord = claim[2]
  0.upto(claim[4]-1) do |y_mod|
    0.upto(claim[3]-1) do |x_mod|
      fabric[y_coord+y_mod][x_coord+x_mod] += 1
    end
  end
end

pp fabric.flatten.select{|square| square > 1}.length
