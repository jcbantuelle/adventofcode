# 1073 Too High

require 'pp'

depth = 11541
target_x = 14
target_y = 778

regions = []
excess = 75
iterations = 300

0.upto(target_y+excess) do |y|
  regions[y] = []
  0.upto(target_x+excess) do |x|
    geologic_index = nil
    if (x == 0 && y == 0) || (x == target_x && y == target_y)
      geologic_index = 0
    elsif x == 0
      geologic_index = y * 48271
    elsif y == 0
      geologic_index = x * 16807
    else
      geologic_index = regions[y][x-1][:erosion] * regions[y-1][x][:erosion]
    end
    erosion = (geologic_index + depth) % 20183
    type = erosion % 3
    regions[y][x] = {
      erosion: erosion,
      type: type,
      equipment: {}
    }
  end
end

regions[0][0][:equipment][:torch] = 0

iterations.times do
  0.upto(target_y+excess) do |y|
    0.upto(target_x+excess) do |x|
      current_region = regions[y][x]
      if current_region[:type] == 0
        if current_region[:equipment][:torch].nil?
          current_region[:equipment][:torch] = current_region[:equipment][:climb] + 7
        elsif current_region[:equipment][:climb] && current_region[:equipment][:torch] + 7 < current_region[:equipment][:climb]
          current_region[:equipment][:climb] = current_region[:equipment][:torch] + 7
        end
        if current_region[:equipment][:climb].nil?
          current_region[:equipment][:climb] = current_region[:equipment][:torch] + 7
        elsif current_region[:equipment][:torch] && current_region[:equipment][:climb] + 7 < current_region[:equipment][:torch]
          current_region[:equipment][:torch] = current_region[:equipment][:climb] + 7
        end
      elsif current_region[:type] == 1
        if current_region[:equipment][:neither].nil?
          current_region[:equipment][:neither] = current_region[:equipment][:climb] + 7
        elsif current_region[:equipment][:climb] && current_region[:equipment][:neither] + 7 < current_region[:equipment][:climb]
          current_region[:equipment][:climb] = current_region[:equipment][:neither] + 7
        end
        if current_region[:equipment][:climb].nil?
          current_region[:equipment][:climb] = current_region[:equipment][:neither] + 7
        elsif current_region[:equipment][:neither] && current_region[:equipment][:climb] + 7 < current_region[:equipment][:neither]
          current_region[:equipment][:neither] = current_region[:equipment][:climb] + 7
        end
      elsif current_region[:type] == 2
        if current_region[:equipment][:neither].nil?
          current_region[:equipment][:neither] = current_region[:equipment][:torch] + 7
        elsif current_region[:equipment][:torch] && current_region[:equipment][:neither] + 7 < current_region[:equipment][:torch]
          current_region[:equipment][:torch] = current_region[:equipment][:neither] + 7
        end
        if current_region[:equipment][:torch].nil?
          current_region[:equipment][:torch] = current_region[:equipment][:neither] + 7
        elsif current_region[:equipment][:neither] && current_region[:equipment][:torch] + 7 < current_region[:equipment][:neither]
          current_region[:equipment][:neither] = current_region[:equipment][:torch] + 7
        end
      end

      current_region[:equipment].each do |item, minutes|
        [[-1,0],[1,0],[0,-1],[0,1]].each do |range|
          y_coord = y + range[0]
          x_coord = x + range[1]
          next if y_coord < 0 || x_coord < 0 || y_coord > (target_y+excess) || x_coord > (target_x+excess)
          next_region = regions[y_coord][x_coord]
          if next_region[:type] == 0 && (item == :climb || item == :torch)
            next_region[:equipment][item] = minutes + 1 if next_region[:equipment][item].nil? || next_region[:equipment][item] > minutes + 1
          end
          if next_region[:type] == 1 && (item == :neither || item == :climb)
            next_region[:equipment][item] = minutes + 1 if next_region[:equipment][item].nil? || next_region[:equipment][item] > minutes + 1
          end
          if next_region[:type] == 2 && (item == :neither || item == :torch)
            next_region[:equipment][item] = minutes + 1 if next_region[:equipment][item].nil? || next_region[:equipment][item] > minutes + 1
          end
        end
      end
    end
  end
end

region = regions[target_y][target_x]
if region[:equipment][:climb]
  region[:equipment][:climb] += 7
end
pp region[:equipment].values.min
