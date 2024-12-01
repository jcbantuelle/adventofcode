require 'pp'

maze = []
tracking = []

File.foreach('input.txt') do |line|
  maze.push(line.chomp.each_char.to_a)
end

y_mod = 1
x_mod = 0
y_pos = 0
x_pos = maze[y_pos].find_index{|m| m == '|'}

loop do
  y_pos += y_mod
  x_pos += x_mod
  break if y_pos < 0 || x_pos < 0 || y_pos >= maze.length || x_pos >= maze[y_pos].length
  char = maze[y_pos][x_pos]
  if char.match(/[a-zA-Z]/)
    tracking.push(char)
  elsif char == '+'
    if x_mod == 0
      y_mod = 0
      if x_pos - 1 >= 0 && maze[y_pos][x_pos-1] != ' '
        x_mod = -1
      else
        x_mod = 1
      end
    elsif y_mod == 0
      x_mod = 0
      if y_pos - 1 >= 0 && maze[y_pos-1][x_pos] != ' '
        y_mod = -1
      else
        y_mod = 1
      end
    end
  elsif char == ' '
    break
  end
end

pp tracking.join
