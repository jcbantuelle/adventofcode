require 'pp'

class Cell
  attr_accessor :contents, :row, :col, :key, :visited

  def initialize(contents, row, col)
    @contents = contents
    @visited = false
    @row = row
    @col = col
    @key = "#{row},#{col}"
  end

  def splitter?
    @contents == '^'
  end

  def visited?
    @visited
  end
end

active_keys = []
cells = {}
File.open('input.txt').each_with_index { |row, r|
  row.chomp.chars.each_with_index { |contents, c|
    cell = Cell.new(contents, r, c)
    cells[cell.key] = cell
    active_keys << cell.key if cell.contents == 'S'
  }
}

until active_keys.empty?
  new_active_keys = []
  active_keys.each do |active_key|
    active = cells[active_key]
    next_cell = cells["#{active.row+1},#{active.col}"]
    if next_cell
      next_cell.visited = true
      if next_cell.splitter?
        left_cell = cells["#{next_cell.row},#{next_cell.col-1}"]
        new_active_keys << left_cell.key if left_cell
        right_cell = cells["#{next_cell.row},#{next_cell.col+1}"]
        new_active_keys << right_cell.key if right_cell
      else
        new_active_keys << next_cell.key
      end
    end
  end
  active_keys = new_active_keys.uniq
end

puts cells.values.select(&:splitter?).select(&:visited?).count
