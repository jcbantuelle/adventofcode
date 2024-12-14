puts File.open('input.txt').each_slice(4).reduce(0) { |tokens, machine|
  a_mod = machine[0].scan(/\d+/).map(&:to_f)
  b_mod = machine[1].scan(/\d+/).map(&:to_f)
  prize = machine[2].scan(/\d+/).map(&:to_f)
  prize[0] += 10000000000000
  prize[1] += 10000000000000
  
  b = ((prize[1]*a_mod[0]) - (a_mod[1]*prize[0])) / ((a_mod[1]*b_mod[0]*-1) + (b_mod[1]*a_mod[0]))
  a = (prize[0] - (b_mod[0]*b)) / a_mod[0]
  spent = a % 1 == 0 && b % 1 == 0 ? (b + (a*3)).to_i : 0
  tokens + spent
}
