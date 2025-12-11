require 'pp'

class Cell
  attr_accessor :contents, :row, :col, :key, :visited, :timelines

  def initialize(contents, row, col)
    @contents = contents
    @visited = false
    @row = row
    @col = col
    @key = "#{row},#{col}"
    @timelines = 0
  end

  def splitter?
    @contents == '^'
  end

  def visited?
    @visited
  end

  def next_cells
    splitter? ? [left_cell, right_cell].compact : [down_cell].compact
  end

  def left_cell
    $cells["#{row},#{col-1}"]
  end

  def right_cell
    $cells["#{row},#{col+1}"]
  end

  def down_cell
    $cells["#{row+1},#{col}"]
  end

  def traverse
    @visited = true
    if next_cells.empty?
      @timelines = 1
    else
      @timelines += next_cells.reduce(0) do |total, cell|
        if cell.visited?
          total + cell.timelines
        else
          total + cell.traverse
        end
      end
    end
    @timelines
  end
end

start = nil
$cells = {}
File.open('input.txt').each_with_index { |row, r|
  row.chomp.chars.each_with_index { |contents, c|
    cell = Cell.new(contents, r, c)
    $cells[cell.key] = cell
    start = cell if cell.contents == 'S'
  }
}

puts start.traverse
