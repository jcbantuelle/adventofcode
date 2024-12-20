require 'pp'

def composable(pattern)
  return 1 if pattern.empty?
  return $seen[pattern] unless $seen[pattern].nil?
  $seen[pattern] = 0
  $towels.each do |towel|
    len = towel.length
    head = pattern[0..(len-1)]
    tail = pattern[len..-1]
    
    $seen[pattern] += composable(tail) if head == towel
  end

  $seen[pattern]
end

input = File.open('input.txt').map(&:chomp)

$towels = input[0].split(', ')
patterns = input[2..-1]

$seen = {}
pp patterns.reduce(0) { |sum, t|
  sum + composable(t)
}
