class DiskFile
  attr_accessor :id, :size

  def initialize(id, size)
    @id = id
    @size = size
  end
end

disk = []
File.open('input.txt').first.chomp.split('').each_with_index {|num, pos|
  id = pos % 2 == 0 ? pos / 2 : nil
  disk << DiskFile.new(id, num.to_i)
}

total = 0
disk_index = 0

loop do
  break if disk.empty?
  file = disk.shift
  if file.id.nil?
    file.size.times do
      id = nil
      loop do
        id = disk[-1].id
        disk[-1].size -= 1
        disk.pop if id.nil? || disk[-1].size == 0
        break unless id.nil?
      end
      total += id * disk_index
      disk_index += 1
    end
  else
    file.size.times do
      total += file.id * disk_index
      disk_index += 1
    end
  end

  unless disk.empty?
    loop do
      break unless disk[-1].id.nil?
      disk.pop
    end
  end
end

puts total
