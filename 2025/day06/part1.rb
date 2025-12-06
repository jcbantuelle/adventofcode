puts File.open('input.txt').map{|row| row.split(' ')}.transpose.reduce(0) { |total, problem|
  total + problem[0..-2].map(&:to_i).inject(&(problem[-1].to_sym))
}
