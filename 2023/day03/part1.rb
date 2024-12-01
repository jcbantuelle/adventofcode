require 'pp'

def print_schematic(schema)
  schema.map{|row|
    in_num = nil
    row.map{|pos|
      if pos.is_a?(Array)
        in_num = 0 if in_num.nil?
        num_str = pos[0].to_s
        val = num_str[in_num]
        in_num += 1
        in_num = nil if in_num == num_str.length
        val
      elsif pos.nil?
        '.'
      else
        pos
      end
    }.join('')
  }
end

schematic = []

File.open('input.txt').each_line.map(&:chomp).each_with_index { |row, col|
  number = ''
  number_start = nil
  schematic[col] = []
  row.each_char.each_with_index do |char, pos|
    if char.match(/\d/)
      number += char
      if number_start.nil?
        number_start = pos
      end
    else
      unless number.empty?
        number_val = number.to_i
        number.length.times do
          schematic[col] << [number_val, number_start]
        end
        number = ''
        number_start = nil
      end
      if char == '.'
        schematic[col] << nil
      else
        schematic[col] << char
      end
    end
  end
  unless number.empty?
    number_val = number.to_i
    number.length.times do
      schematic[col] << [number_val, number_start]
    end
  end
}

parts_sum = 0

schematic.each_with_index do |row, row_pos|
  row.each_with_index do |elem, col_pos|
    if elem.is_a?(String)
      (-1..1).each do |row_mod|
        (-1..1).each do |col_mod|
          row_check = row_pos + row_mod
          col_check = col_pos + col_mod
          next if row_check == row_pos && col_check == col_pos
          next if row_check < 0 || row_check == schematic.length
          next if col_check < 0 || col_check > row.length
          part = schematic[row_check][col_check]
          if part.is_a?(Array)
            parts_sum += part[0]
            erase_index = part[1]
            part[0].to_s.length.times do |i|
              schematic[row_check][erase_index] = nil
              erase_index += 1
            end
          end
        end
      end
    end
  end
end

pp parts_sum
