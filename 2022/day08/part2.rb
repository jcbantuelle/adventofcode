require 'pp'

def visible_count(range, tree, other_axis, change_x)
  counter = 0
  range.each do |coord|
    counter += 1
    if change_x
      break if $trees[other_axis][coord] >= tree
    else
      break if $trees[coord][other_axis] >= tree
    end
  end
  counter
end

$trees = File.open('input.txt').each_line.map{ |line|
  line.chomp.chars.to_a.map(&:to_i)
}

highest_scenic = 0

$trees.each_with_index do |row, y|
  row.each_with_index do |tree, x|
    scenic = visible_count((x-1).downto(0), tree, y, true) *
      visible_count((x+1).upto(row.length-1), tree, y, true) *
      visible_count((y-1).downto(0), tree, x, false) *
      visible_count((y+1).upto($trees.length-1), tree, x, false)

    highest_scenic = scenic if scenic > highest_scenic
  end
end

pp highest_scenic
