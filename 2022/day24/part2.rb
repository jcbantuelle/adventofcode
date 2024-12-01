require 'pp'

class Blizzard
  attr_accessor :x, :y, :facing

  def initialize(x, y, facing)
    @x = x
    @y = y
    @facing = facing
  end

  def move
    case @facing
    when '<'
      @x -= 1
      @x = $max_x if @x < 0
    when '>'
      @x += 1
      @x = 0 if @x > $max_x
    when '^'
      @y -= 1
      @y = $max_y if @y < 0
    when 'v'
      @y += 1
      @y = 0 if @y > $max_y
    end
  end

  def to_s
    "#{@x},#{@y}"
  end

  def to_index
    "#{to_s},#{@facing}"
  end
end

class Valley
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def move
    to_occupy = {}
    new_valleys = []
    [[-1,0], [1,0], [0,1], [0,-1], [0,0]].each do |possible_move|
      new_x = @x + possible_move[0]
      new_y = @y + possible_move[1]
      seen_index = "#{new_x},#{new_y},#{$blizzard_index}"
      if $seen[seen_index]
        next unless new_y == -1 && possible_move == [0,0]
      end
      $seen[seen_index] = true
      if new_x == $max_x && new_y == $max_y + 1
        pp $first_pass + $second_pass + $steps
        pp "Finished in: #{Time.now - $start}s"
        exit
      end
      next if $occupied["#{new_x},#{new_y}"] || new_x < 0 || new_x > $max_x || new_y > $max_y || (new_y < 0 && possible_move != [0,0])
      new_valleys << Valley.new(new_x, new_y)
    end
    new_valleys
  end
end

valley_rows = File.open('input.txt').each_line.map(&:chomp)[1..-2]
$seen = {}
$max_x = valley_rows.first.length - 3
$max_y = valley_rows.length - 1
$blizzards = []

valley_rows.each_with_index do |row, y|
  row.chomp[1..-2].chars.each_with_index do |space, x|
    $blizzards << Blizzard.new(x, y, space) if %w(< > ^ v).include?(space)
  end
end
valleys = [Valley.new(0, -1)]

$first_pass = 301
$second_pass = 269
($first_pass+$second_pass).times do
  $blizzards.each do |blizzard|
    blizzard.move
  end
end

$start = Time.now
$steps = 1
loop do
  $occupied = {}
  $blizzards.each do |blizzard|
    blizzard.move
    $occupied["#{blizzard}"] = true
  end
  $blizzard_index = $blizzards.map(&:to_index).sort.join(',')
  valleys = valleys.map{|valley|
    valley.move
  }.flatten
  $steps += 1
end
