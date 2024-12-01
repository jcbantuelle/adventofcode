require 'pp'

$minimum_energy = 999999999999

$win_condition = [
  ['A','A','A','A'],
  ['B','B','B','B'],
  ['C','C','C','C'],
  ['D','D','D','D']
]

$energy = {
  'A' => 1,
  'B' => 10,
  'C' => 100,
  'D' => 1000
}

$room_targets = {
  'A' => [2,0],
  'B' => [4,1],
  'C' => [6,2],
  'D' => [8,3],
}

$hall_openings = [
  2,
  4,
  6,
  8
]

$seen = {}

class Layout
  attr_reader :rooms, :hall

  def initialize(rooms, hall)
    @rooms = rooms
    @hall = hall
  end

  def win?
    rooms == $win_condition
  end

  def to_s
    "#############\n##{hall.join('')}#\n####{rooms[0][0]}##{rooms[1][0]}##{rooms[2][0]}##{rooms[3][0]}###\n  ##{rooms[0][1]}##{rooms[1][1]}##{rooms[2][1]}##{rooms[3][1]}#\n  #########"
  end

  def serialize
    rooms.flatten.join(',') + ':' + hall.join(',')
  end
end

def move(layout, energy)
  serialized_layout = layout.serialize
  return if $seen[serialized_layout] && $seen[serialized_layout] <= energy
  $seen[serialized_layout] = energy
  if layout.win?
    $minimum_energy = energy
  else
    hall = layout.hall
    rooms = layout.rooms
    hall.each_with_index do |tile, hall_index|
      if tile != '.'
        room_target = $room_targets[tile]
        hall_steps = [hall_index, room_target[0]].sort
        hall_steps = (hall_steps[0]..hall_steps[1]).to_a
        valid_walk = true
        hall_steps.each do |hall_step|
          next if hall_step == hall_index
          valid_walk = false if hall[hall_step] != '.'
        end
        if valid_walk
          target_room = rooms[room_target[1]]
          if target_room.all?{ |room| [tile, '.'].include?(room) }
            hall_energy = hall_steps.length-1
            room_energy = target_room.count('.')
            expended_energy = (hall_energy+room_energy) * $energy[tile] + energy
            unless expended_energy >= $minimum_energy
              new_hall = hall.dup
              new_rooms = rooms.map{|room| room.dup}
              new_hall[hall_index] = '.'
              new_rooms[room_target[1]][room_energy-1] = tile
              new_layout = Layout.new(new_rooms, new_hall)
              move(new_layout, expended_energy)
            end
          end
        end
      end
    end
    rooms.each_with_index do |room, room_index|
      target_tile = $win_condition[room_index][0]
      room_energy = nil
      tile = nil
      if room[0] != '.' && (target_tile != room[0] || target_tile != room[1] || target_tile != room[2] || target_tile != room[3])
        room_energy = 1
        tile = room[0]
      elsif room[1] != '.' && (target_tile != room[1] || target_tile != room[2] || target_tile != room[3])
        room_energy = 2
        tile = room[1]
      elsif room[2] != '.' && (target_tile != room[2] || target_tile != room[3])
        room_energy = 3
        tile = room[2]
      elsif room[3] != '.' && target_tile != room[3]
        room_energy = 4
        tile = room[3]
      end
      unless room_energy.nil?
        hall_indicies = []
        # Left hall
        left_hall = hall[0...$hall_openings[room_index]]
        (left_hall.length-1).downto(0) do |hall_index|
          break if hall[hall_index] != '.'
          hall_indicies.push(hall_index) unless $hall_openings.include?(hall_index)
        end
        # Right hall
        (left_hall.length+1).upto(hall.length-1) do |hall_index|
          break if hall[hall_index] != '.'
          hall_indicies.push(hall_index) unless $hall_openings.include?(hall_index)
        end
        hall_indicies.each do |hall_index|
          hall_energy = ($hall_openings[room_index] - hall_index).abs
          expended_energy = (hall_energy+room_energy) * $energy[tile] + energy
          unless expended_energy >= $minimum_energy
            new_hall = hall.dup
            new_rooms = rooms.map{|room| room.dup}
            new_hall[hall_index] = tile
            new_rooms[room_index][room_energy-1] = '.'
            new_layout = Layout.new(new_rooms, new_hall)
            move(new_layout, expended_energy)
          end
        end
      end
    end
  end
end

room_start = [
  ['D','D','D','D'],
  ['A','C','B','A'],
  ['C','B','A','B'],
  ['C','A','C','B']
]

layout = Layout.new(room_start, Array.new(11,'.'))
move(layout, 0)

pp $minimum_energy
