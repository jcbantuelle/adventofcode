require 'pp'

trees = File.open('input.txt').each_line.map{ |line|
  line.chomp.chars.to_a.map(&:to_i)
}

visible_trees = 0

trees.each_with_index do |row, y|
  row.each_with_index do |tree, x|
    visible = true
    (x-1).downto(0) do |x_coord|
      if trees[y][x_coord] >= tree
        visible = false
        break
      end
    end
    if visible
      visible_trees += 1
      next
    end

    visible = true
    (x+1).upto(row.length-1) do |x_coord|
      if trees[y][x_coord] >= tree
        visible = false
        break
      end
    end
    if visible
      visible_trees += 1
      next
    end

    visible = true
    (y-1).downto(0) do |y_coord|
      if trees[y_coord][x] >= tree
        visible = false
        break
      end
    end
    if visible
      visible_trees += 1
      next
    end

    visible = true
    (y+1).upto(trees.length-1) do |y_coord|
      if trees[y_coord][x] >= tree
        visible = false
        break
      end
    end
    if visible
      visible_trees += 1
      next
    end
  end
end

pp visible_trees
