require 'pp'

password = 'abcdefgh'.each_char.to_a

File.foreach('input.txt') do |line|
  step = line.chomp.split(' ')
  if step[0] == 'swap'
    if step[1] == 'position'
      pos1 = step[2].to_i
      pos2 = step[5].to_i
      password[pos1], password[pos2] = password[pos2], password[pos1]
    elsif step[1] == 'letter'
      pos1 = password.find_index{|letter| letter == step[2]}
      pos2 = password.find_index{|letter| letter == step[5]}
      password[pos1], password[pos2] = password[pos2], password[pos1]
    end
  elsif step[0] == 'rotate'
    if step[1] == 'based'
      pos = password.find_index{|letter| letter == step[6]}
      rotations = 1 + pos
      rotations += 1 if pos >= 4
      rotations.times do
        password.unshift(password.pop)
      end
    elsif step[1] == 'left'
      step[2].to_i.times do
        password.push(password.shift)
      end
    elsif step[1] == 'right'
      step[2].to_i.times do
        password.unshift(password.pop)
      end
    end
  elsif step[0] == 'reverse'
    start_pos = step[2].to_i
    end_pos = step[4].to_i
    password[start_pos..end_pos] = password[start_pos..end_pos].reverse
  elsif step[0] == 'move'
    old_pos = step[2].to_i
    new_pos = step[5].to_i
    password.insert(new_pos, password.delete_at(old_pos))
  end
end

pp password.join('')
