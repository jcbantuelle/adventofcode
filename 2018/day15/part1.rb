require 'pp'

class Node

  attr_accessor :up, :down, :left, :right, :visited, :path, :occupant, :row, :col

  def initialize(cell, row, col)
    reset
    @row = row
    @col = col
    @occupant = %w(G E).include?(cell) ? Combatant.new(cell, row, col) : nil
  end

  def reset
    @visited = false
    @path = nil
  end

  def index
    "#{@row},#{@col}"
  end

  def empty?
    @occupant.nil?
  end

  def populate_neighbors(matrix)
    unless @row - 1 < 0
      up_neighbor = matrix[@row-1][@col]
      @up = up_neighbor unless up_neighbor.nil?
    end
    unless matrix[@row+1].nil?
      down_neighbor = matrix[@row+1][@col]
      @down = down_neighbor unless down_neighbor.nil?
    end
    unless @col - 1 < 0
      left_neighbor = matrix[@row][@col-1]
      @left = left_neighbor unless left_neighbor.nil?
    end
    unless matrix[@row][@col+1].nil?
      right_neighbor = matrix[@row][@col+1]
      @right = right_neighbor unless right_neighbor.nil?
    end
  end

  def move(nodes)
    return self if (up && up.occupant && up.occupant.race == occupant.opponent) ||
      (left && left.occupant && left.occupant.race == occupant.opponent) ||
      (right && right.occupant && right.occupant.race == occupant.opponent) ||
      (down && down.occupant && down.occupant.race == occupant.opponent)
    nodes[index].path = []
    next_node = nil
    loop do
      next_node = nodes.values.select{ |node|
        !node.visited && node.path && (node.occupant.nil? || node.index == index)
      }.sort.min{ |a,b| a.path.length <=> b.path.length}
      break if next_node.nil?
      next_node.visited = true
      new_path = next_node.path.dup
      new_path << next_node
      next_node.up.path = new_path unless next_node.up.nil? || (next_node.up.path && (next_node.up.path.length < new_path.length || (next_node.up.path.length == new_path.length && next_node.up.path[1] < new_path[1])))
      next_node.left.path = new_path unless next_node.left.nil? || (next_node.left.path && (next_node.left.path.length < new_path.length || (next_node.left.path.length == new_path.length && next_node.left.path[1] < new_path[1])))
      next_node.right.path = new_path unless next_node.right.nil? || (next_node.right.path && (next_node.right.path.length < new_path.length || (next_node.right.path.length == new_path.length && next_node.right.path[1] < new_path[1])))
      next_node.down.path = new_path unless next_node.down.nil? || (next_node.down.path && (next_node.down.path.length < new_path.length || (next_node.down.path.length == new_path.length && next_node.down.path[1] < new_path[1])))
    end
    destination = nodes.values.select{ |node|
      node.path && node.occupant && node.occupant.race == occupant.opponent
    }.min{ |a,b| a.path.length <=> b.path.length}
    if destination.nil?
      return self
    else
      next_node = destination.path[1]
      next_node.occupant = @occupant
      @occupant = nil
      next_node
    end
  end

  def attack
    target = [up, left, right, down].select{ |node|
      node && node.occupant && node.occupant.race == occupant.opponent
    }.min{|a,b| a.occupant.hp <=> b.occupant.hp}
    if target
      target.occupant.hp -= 3
      target.occupant = nil if target.occupant.hp < 1
    end
  end

  def <(other)
    weighted_value < other.weighted_value
  end

  def <=>(other)
    weighted_value <=> other.weighted_value
  end

  def weighted_value
    @row * 10000 + @col
  end
end

class Combatant

  attr_accessor :race, :row, :col, :hp, :turn_taken

  def initialize(race, row, col)
    @race = race
    @row = row
    @col = col
    @hp = 200
    reset
  end

  def reset
    @turn_taken = false
  end

  def index
    "#{row},#{col}"
  end

  def <=>(other)
    weighted_value <=> other.weighted_value
  end

  def weighted_value
    @row * 10000 + @col
  end

  def opponent
    @race == 'G' ? 'E' : 'G'
  end

end

def print_matrix(matrix, nodes)
  matrix.each_with_index do |row, row_index|
    row.each_with_index do |_, col_index|
      node = nodes["#{row_index},#{col_index}"]
      if node.nil?
        matrix[row_index][col_index] = '#'
      elsif node.occupant.nil?
        matrix[row_index][col_index] = '.'
      else
        matrix[row_index][col_index] = node.occupant.race
      end
    end
  end
  matrix.each do |row|
    pp row.join
  end
end

matrix = []
File.foreach('input.txt') do |line|
  row = []
  line.chomp.chars.each_with_index do |cell, col|
    node = cell == '#' ? nil : Node.new(cell, matrix.length, col)
    row << node
  end
  matrix << row
end

nodes = {}
combatants = []
matrix.each_with_index do |row, row_index|
  row.each_with_index do |node, col_index|
    unless node.nil?
      node.populate_neighbors(matrix)
      nodes[node.index] = node
      combatants << node.occupant unless node.empty?
    end
  end
end

round = 1

loop do
  # pp "Round: #{round}"
  # print_matrix(matrix, nodes)
  # pp ""
  while combatants.reject(&:turn_taken).length > 0
    combatant = combatants.reject(&:turn_taken).first
    combatant_node = nodes[combatant.index]
    move_node = combatant_node.move(nodes)
    nodes.values.each(&:reset)
    combatant.row = move_node.row
    combatant.col = move_node.col
    move_node.attack
    combatant.turn_taken = true
    combatants.reject!{|c|
      c.hp < 1
    }
    if combatants.map(&:race).uniq.length == 1
      pp combatants.map(&:hp).inject(&:+) * round
      exit
    end
  end
  combatants.each(&:reset)
  combatants.sort!
  round += 1
end
