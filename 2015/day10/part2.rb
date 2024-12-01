require 'pp'

key = [1,1,1,3,2,2,2,1,1,3]

start = Time.now
50.times do
  digit = nil
  count = 0
  new_key = []
  key.each do |number|
    digit = number if digit.nil?
    if digit != number
      new_key.push(count)
      new_key.push(digit)
      digit = number
      count = 1
    else
      count += 1
    end
  end
  new_key.push(count)
  new_key.push(key.last)
  key = new_key
end
pp Time.now - start
pp key.length
