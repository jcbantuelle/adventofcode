crate_stacks = [
  %w(J F C N D B W),
  %w(T S L Q V Z P),
  %w(T J G B Z P),
  %w(C H B Z J L T D),
  %w(S J B V G),
  %w(Q S P),
  %w(N P M L F D V B),
  %w(R L D B F M S P),
  %w(R T D V)
]

File.open('input.txt').each_line do |line|
  parsed_line = line.split(' ')
  crates_to_move = parsed_line[1].to_i
  start_stack = parsed_line[3].to_i - 1
  end_stack = parsed_line[5].to_i - 1
  crate_stacks[end_stack].unshift(*crate_stacks[start_stack].shift(crates_to_move))
end

puts crate_stacks.map(&:first).join
