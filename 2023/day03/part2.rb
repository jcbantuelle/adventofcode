schematic = []
number_id = 1

File.open('input.txt').each_line.map(&:chomp).each_with_index { |row, col|
  number = ''
  schematic[col] = []
  row.each_char.each_with_index do |char, pos|
    if char.match(/\d/)
      number += char
    else
      unless number.empty?
        number_val = number.to_i
        number.length.times do
          schematic[col] << [number_val, number_id]
        end
        number = ''
        number_id += 1
      end
      if char != '*'
        schematic[col] << nil
      else
        schematic[col] << char
      end
    end
  end
  unless number.empty?
    number_val = number.to_i
    number.length.times do
      schematic[col] << [number_val, number_id]
    end
    number_id += 1
  end
}

gear_ratio = 0

schematic.each_with_index do |row, row_pos|
  row.each_with_index do |elem, col_pos|
    if elem == '*'
      parts = []
      part_ids = []
      (-1..1).each do |row_mod|
        (-1..1).each do |col_mod|
          row_check = row_pos + row_mod
          col_check = col_pos + col_mod
          next if row_check == row_pos && col_check == col_pos
          next if row_check < 0 || row_check == schematic.length
          next if col_check < 0 || col_check > row.length
          part = schematic[row_check][col_check]
          if part.is_a?(Array)
            next if part_ids.include?(part[1])
            parts << part[0]
            part_ids << part[1]
          end
        end
      end
      if parts.length == 2
        gear_ratio += parts.inject(&:*)
      end
    end
  end
end

puts gear_ratio
