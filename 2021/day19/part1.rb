require 'pp'

def reorient(scanner)
  orientations = []
  [0,1,2].permutation(3).to_a.each { |axis|
    [-1, 1].repeated_permutation(3).to_a.each { |direction|
      orientations.push(scanner.map { |beacon|
        [
          beacon[axis[0]] * direction[0],
          beacon[axis[1]] * direction[1],
          beacon[axis[2]] * direction[2]
        ]
      })
    }
  }
  orientations
end

unoriented_scanners = []
index = -1
File.foreach('input.txt') do |line|
  line = line.chomp
  next if line.empty?
  if line.include?('---')
    index += 1
    unoriented_scanners[index] = []
  else
    unoriented_scanners[index].push(line.split(',').map(&:to_i))
  end
end

oriented_beacons = unoriented_scanners.shift

start = Time.now
while !unoriented_scanners.empty?
  unoriented_scanner_deletions = []
  unoriented_scanners.each_with_index do |unoriented_scanner, index|
    pp index
    found_orientation = false
    reoriented_scanners = reorient(unoriented_scanner)
    reoriented_scanners.each do |scanner|
      oriented_beacons.each do |oriented_beacon|
        scanner.each do |unoriented_beacon|
          x_mod = oriented_beacon[0] - unoriented_beacon[0]
          y_mod = oriented_beacon[1] - unoriented_beacon[1]
          z_mod = oriented_beacon[2] - unoriented_beacon[2]
          reoriented_beacons = scanner.map{|beacon|
            [
              beacon[0] + x_mod,
              beacon[1] + y_mod,
              beacon[2] + z_mod
            ]
          }
          if (reoriented_beacons & oriented_beacons).length >= 12
            oriented_beacons += reoriented_beacons
            oriented_beacons.uniq!
            unoriented_scanner_deletions.push(index)
            found_orientation = true
            break
          end
        end
        break if found_orientation
      end
      break if found_orientation
    end
  end
  new_scanners = []
  unoriented_scanners.each_with_index do |scanner, index|
    new_scanners.push(scanner) unless unoriented_scanner_deletions.include?(index)
  end
  unoriented_scanners = new_scanners
end
pp Time.now-start

pp oriented_beacons.length
