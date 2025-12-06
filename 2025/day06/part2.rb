new_row = true
puts File.open('input.txt').map(&:chomp).map(&:chars).transpose.reduce([]) { |problems, row|
  if new_row
    problems << [row[-1], [row[0..-2].join.to_i]]
    new_row = false
  else
    number = row.join.strip
    if number.empty?
      new_row = true
    else
      problems[-1][-1] << number.to_i
    end
  end
  problems
}.reduce(0) { |total, problem|
  total + problem[-1].inject(&(problem[0].to_sym))
}
