require 'pp'

$matches = {}

class Grid
  def initialize(grid)
    @grid = grid.split('/').map(&:each_char).map(&:to_a)
  end

  def rotate
    @grid = @grid.transpose.map(&:reverse)
  end

  def rotate
    @grid = @grid.transpose.map(&:reverse)
  end

  def flip
    @grid.reverse.map(&:join).join('/')
  end

  def enhance
    slice = @grid.count % 2 == 0 ? 2 : 3
    grids = @grid.each_slice(slice).to_a
    chunks = grids[0].count
    @grid = grids.map{ |chunk|
      chunk.map{|c|
        c.each_slice(slice).to_a
      }.transpose.map{|s|
        s.map(&:join).join('/')
      }
    }.flatten.map{|g|
      $matches[g].split('/')
    }.each_slice(chunks).to_a.map{|g|
      g.transpose.map(&:join)
    }.flatten.map{|g|
      g.each_char.to_a
    }
  end

  def to_s
    @grid.map(&:join).join('/')
  end
end

File.foreach('input.txt') do |line|
  left, right = line.chomp.split(' => ')
  left_grid = Grid.new(left)
  right_grid = Grid.new(right).to_s
  5.times do
    $matches[left_grid.to_s] = right_grid
    $matches[left_grid.flip] = right_grid
    left_grid.rotate
  end
end

grid = Grid.new('.#./..#/###')
5.times do
  grid.enhance
end

pp grid.to_s.count('#')
