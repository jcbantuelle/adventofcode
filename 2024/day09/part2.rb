class DiskFile
  attr_accessor :id, :size, :moved

  def initialize(id, size)
    @id = id
    @size = size
    @moved = false
  end
end

disk = []
File.open('input.txt').first.chomp.split('').each_with_index {|num, pos|
  id = pos % 2 == 0 ? pos / 2 : nil
  disk << DiskFile.new(id, num.to_i)
}

(disk.length-1).downto(1) do |file_index|
  next if disk[file_index].id.nil? || disk[file_index].moved
  space_index = disk.find_index{|file|
    file.id.nil? && disk[file_index].size <= file.size
  }
  unless space_index.nil? || space_index >= file_index
    file_to_move = disk[file_index].dup 
    file_to_move.moved = true
    disk[file_index].id = nil
    if disk[space_index].size == file_to_move.size
      disk[space_index] = file_to_move
    else
      disk[space_index].size -= file_to_move.size
      disk.insert(space_index, file_to_move)
    end
  end
end

total = 0
disk_index = 0

disk.each do |file|
  file.size.times do
    total += file.id * disk_index unless file.id.nil?
    disk_index += 1
  end
end

puts total
