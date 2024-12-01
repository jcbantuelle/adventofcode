require 'pp'

$seen = {}

$original_parts = %w(P T O R C)
layouts = [{
  floors: [
    ['PG', 'TG', 'TM', 'OG', 'RG', 'RM', 'CG', 'CM'],
    ['PM', 'OM'],
    [],
    []
  ],
  elevator: 0,
  moves: 0
}]

$parts_permutations = $original_parts.permutation($original_parts.length).to_a

def serialize(layout)
  layout[:floors].map{|floor| floor.sort.join(',')}.join(';') + '-' + layout[:elevator].to_s
end

def memoize_equivalent_serializations(layout)
  $parts_permutations.each do |parts|
    new_layout = {
      elevator: layout[:elevator]
    }
    new_layout[:floors] = layout[:floors].map { |floor|
      floor.map {|part|
        permutation_index = $original_parts.find_index(part[0])
        parts[permutation_index] + part[1]
      }
    }
    $seen[serialize(new_layout)] = true
  end
end

def valid_layout?(layout)
  serialized_layout = serialize(layout)

  seen_before = $seen[serialized_layout]
  return false if seen_before
  memoize_equivalent_serializations(layout)

  safe = layout[:floors].all?{ |floor|
    floor.all?{ |item|
      if item[1] == 'M'
        floor.include?("#{item[0]}G") || floor.none?{|item2| item2[1] == 'G'}
      else
        true
      end
    }
  }
  return false unless safe

  if layout[:floors][3].length == $original_parts.length*2
    pp Time.now-$start
    pp layout[:moves]
    exit
  end
  return true
end

def generate_layout(layout, elevator_mod, selections)
  new_floors = layout[:floors].map(&:dup)
  new_elevator = layout[:elevator] + elevator_mod
  selections.each do |selection|
    new_floors[layout[:elevator]].delete(selection)
  end
  new_floors[new_elevator].concat(selections)
  new_layout = {
    floors: new_floors,
    elevator: new_elevator,
    moves: layout[:moves] + 1
  }
  valid_layout?(new_layout) ? new_layout : nil
end

$start = Time.now
loop do
  new_layouts = []
  layouts.each do |layout|
    floors = layout[:floors]
    elevator = layout[:elevator]
    selections = []
    selections = floors[elevator].combination(2).to_a if floors[elevator].length > 1
    selections.concat(floors[elevator].map{|item| [item]})
    move_two_up = false

    selections.each do |selection|
      if elevator != 3
        unless selection.length == 1 && (floors[elevator..3].all?(&:empty?) || move_two_up)
          new_layout = generate_layout(layout, 1, selection)
          unless new_layout.nil?
            new_layouts.push(new_layout)
            move_two_up = true if selection.length == 2
          end
        end
      end
      if selection.length == 1 && elevator != 0
        unless floors[0..elevator-1].all?(&:empty?)
          new_layout = generate_layout(layout, -1, selection)
          new_layouts.push(new_layout) unless new_layout.nil?
        end
      end
    end
  end
  layouts = new_layouts
end
