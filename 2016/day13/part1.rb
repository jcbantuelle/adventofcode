# Dijkstra's algorithm
require 'pp'

$favorite = 1352
destination = '31,39'

$all_nodes = {}
$unvisited_nodes = {}

def open?(x,y)
  (x*x + 3*x + 2*x*y + y + y*y + $favorite).to_s(2).count('1') % 2 == 0
end

def new_node(x,y)
  node_key = "#{x},#{y}"
  node = {
    visited: false,
    distance: Float::INFINITY,
    value: 1,
    x: x,
    y: y,
    neighbors: nil
  }
  $all_nodes[node_key] = node
  $unvisited_nodes[node_key] = node
  node
end

def generate_neighbors(node)
  node[:neighbors] = {}
  neighbor_indicies = [-1,1].flat_map{ |offset|
    x_offset = node[:x]+offset
    y_offset = node[:y]+offset
    x_coords = x_offset < 0 ? nil : [x_offset, node[:y]]
    y_coords = y_offset < 0 ? nil : [node[:x], y_offset]
    [x_coords, y_coords].compact
  }
  neighbor_indicies.each do |neighbor_index|
    neighbor_key = "#{neighbor_index[0]},#{neighbor_index[1]}"
    existing_node = $all_nodes[neighbor_key]
    if existing_node
      node[:neighbors][neighbor_key] = existing_node unless existing_node[:visited]
    else
      node[:neighbors][neighbor_key] = new_node(*neighbor_index) if open?(*neighbor_index)
    end
  end
end

node = new_node(1,1)
node[:distance] = 0

start = Time.now
loop do
  node_key, node = $unvisited_nodes.first
  if node_key == destination
    pp node[:distance]
    break
  end
  $unvisited_nodes.delete(node_key)
  generate_neighbors(node) if node[:neighbors].nil?
  node[:neighbors].each do |key, neighbor|
    distance = node[:distance] + neighbor[:value]
    neighbor[:distance] = distance if neighbor[:distance] > distance
  end
  node[:visited] = true
end
pp Time.now-start
