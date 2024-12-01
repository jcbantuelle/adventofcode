require 'pp'

def valid_board(board)
  # rows
  row_sums = board.map{|row| row.inject(&:+)}
  return true if row_sums.include?(-5)
  # columns
  col_sums = (0..4).to_a.map do |column_index|
    board.map{|row| row[column_index]}.inject(&:+)
  end
  return true if col_sums.include?(-5)
  diag1 = board[0][0] + board[1][1] + board[2][2] + board[3][3] + board[4][4]
  return true if diag1 == -5
  diag2 = board[0][4] + board[1][3] + board[2][2] + board[3][1] + board[4][0]
  return true if diag2 == -5
end

def sum_board(board)
  board.flatten.map{|number| number == -1 ? 0 : number}.inject(&:+)
end

first_line = true
board_index = -1
boards = []
numbers = nil

File.foreach('input.txt') do |line|
  if first_line
    numbers = line.chomp.split(',').map(&:to_i)
    first_line = false
  else
    if line.chomp.empty?
      board_index += 1
      boards[board_index] = []
    else
      boards[board_index].push(line.chomp.split(' ').map(&:to_i))
    end
  end
end

numbers.each do |number|
  boards.each_with_index do |board, board_index|
    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        boards[board_index][row_index][cell_index] = -1 if cell == number
      end
    end
  end
  if boards.length > 1
    boards.reject!{|board|
      valid_board(board)
    }
  else
    if valid_board(boards[0])
      pp sum_board(boards[0]) * number
      break
    end
  end
end
