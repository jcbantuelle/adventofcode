require 'pp'

def weight_above(tower_name)
  weight = 0
  $towers[tower_name][:children].each do |child_name|
    if $towers[child_name][:children].nil?
      weight += $towers[child_name][:weight]
    else
      weight += weight_above(child_name)
    end
  end
  $towers[tower_name][:weight_above] = weight + $towers[tower_name][:weight]
end

def find_imbalance(tower_name)
  children = $towers[tower_name][:children].map { |child_name|
    child = $towers[child_name]
    [child_name, child[:weight_above]]
  }
  first_child = children[0]
  filtered = children.reject { |child|
    child[1] == first_child[1]
  }

  imbalanced = nil
  balanced = nil
  if filtered.length == 1
    imbalanced = filtered[0]
    balanced = first_child
  elsif filtered.length == children.length - 1
    imbalanced = first_child
    balanced = filtered[0]
  end

  if imbalanced
    child_imbalance = find_imbalance(imbalanced[0])
    if child_imbalance
      return child_imbalance
    else
      offset = imbalanced[1] - balanced[1]
      return $towers[imbalanced[0]][:weight] - offset
    end
  else
    return false
  end
end

$towers = {}

File.foreach('input.txt') do |line|
  tower = line.chomp.match(/([a-z]*)\s\((\d*)\)/)
  tower_data = {
    weight: tower[2].to_i
  }
  children = line.chomp.match(/\->\s(.*)/)
  tower_data[:children] = children[1].split(', ') if children
  $towers[tower[1]] = tower_data
end

bottom_tower = 'vtzay'

weight_above(bottom_tower)
pp find_imbalance(bottom_tower)

# pp $towers[bottom_tower][:children].map { |child_name|
#   "#{child_name}: #{$towers[child_name][:weight_above]}"
# }
