def composable(pattern)
  return true if pattern.empty?
  return $seen[pattern] unless $seen[pattern].nil?
  $seen[pattern] = false
  $towels.each do |towel|
    len = towel.length
    head = pattern[0..(len-1)]
    tail = pattern[len..-1]

    $seen[pattern] = true if head == towel && composable(tail)
  end

  $seen[pattern]
end

input = File.open('input.txt').map(&:chomp)

$towels = input[0].split(', ')
patterns = input[2..-1]

$seen = {}
puts patterns.select{ |t|
  composable(t)
}.length
