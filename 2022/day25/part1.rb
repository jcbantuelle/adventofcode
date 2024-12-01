require 'pp'

start = Time.now
snafu = File.open('input.txt').inject(0){|sum, line|
  line.chomp.reverse.chars.each_with_index do |digit, power|
    digit = '-1' if digit == '-'
    digit = '-2' if digit == '='
    sum += (digit.to_i * (5**power))
  end
  sum
}.to_s(5).reverse.chars.map(&:to_i)

snafu.length.times do |i|
  digit = snafu[i]
  if digit == 3
    snafu[i] = '='
    snafu[i+1] ||= 0
    snafu[i+1] += 1
  elsif digit == 4
    snafu[i] = '-'
    snafu[i+1] ||= 0
    snafu[i+1] += 1
  elsif digit == 5
    snafu[i] = '0'
    snafu[i+1] ||= 0
    snafu[i+1] += 1
  else
    snafu[i] = digit.to_s
  end
end
pp snafu.reverse.join
pp "Finished in: #{Time.now - start}s"
