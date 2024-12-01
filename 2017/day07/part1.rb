require 'pp'

towers = []

File.foreach('input.txt') do |line|
  tower = line.chomp.match(/([a-z]*)\s\((\d*)\)/)
  tower_data = {
    name: tower[1],
    weight: tower[2].to_i
  }
  children = line.chomp.match(/\->\s(.*)/)
  tower_data[:children] = children[1].split(', ') if children
  towers.push(tower_data)
end

tower_names = towers.map{|tower| tower[:name]}
towers.each do |tower|
  if tower[:children]
    tower[:children].each do |child|
      tower_names.delete(child)
    end
  end
end

pp tower_names[0]
