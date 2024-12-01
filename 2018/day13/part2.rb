require 'pp'

class Cart
  attr_accessor :orientation, :row, :col, :turns, :moved

  def initialize(orientation, row, col)
    @orientation = orientation
    @row = row
    @col = col
    @turns = 0
    @moved = false
  end

  def track
    %w(^ v).include?(@orientation) ? '|' : '-'
  end

  def intersect
    if @turns == 0
      case @orientation
      when '^'
        @orientation = '<'
      when '<'
        @orientation = 'v'
      when 'v'
        @orientation = '>'
      when '>'
        @orientation = '^'
      end
    elsif turns == 2
      case @orientation
      when '^'
        @orientation = '>'
      when '<'
        @orientation = '^'
      when 'v'
        @orientation = '<'
      when '>'
        @orientation = 'v'
      end
    end
    @turns += 1
    @turns = 0 if @turns > 2
  end

  def <=>(other)
    weighted_value <=> other.weighted_value
  end

  def weighted_value
    @row * 10000 + @col
  end
end

track = []
carts = []
File.foreach('input.txt') do |line|
  row = []
  line.chomp.chars.each_with_index do |cell, col|
    if %w(^ v < >).include?(cell)
      cart = Cart.new(cell, track.length, col)
      carts << cart
      row << [cart.track, cell]
    else
      row << [cell, nil]
    end
  end
  track << row
end

(track[0].length - track[-1].length).times do
  track[-1].push(' ')
end

loop do
  while carts.reject(&:moved).length > 0
    cart = carts.reject(&:moved).sort[0]
    track[cart.row][cart.col][1] = nil
    if cart.orientation == '^'
      cart.row -= 1
    elsif cart.orientation == 'v'
      cart.row += 1
    elsif cart.orientation == '<'
      cart.col -= 1
    elsif cart.orientation == '>'
      cart.col += 1
    end
    next_track = track[cart.row][cart.col]
    if next_track[1].nil?
      case next_track[0]
      when '\\'
        if cart.orientation == '^'
          cart.orientation = '<'
        elsif cart.orientation == 'v'
          cart.orientation = '>'
        elsif cart.orientation == '<'
          cart.orientation = '^'
        else
          cart.orientation = 'v'
        end
      when '/'
        if cart.orientation == '^'
          cart.orientation = '>'
        elsif cart.orientation == 'v'
          cart.orientation = '<'
        elsif cart.orientation == '<'
          cart.orientation = 'v'
        else
          cart.orientation = '^'
        end
      when '+'
        cart.intersect
      end
      track[cart.row][cart.col][1] = cart.orientation
      cart.moved = true
    else
      track[cart.row][cart.col][1] = nil
      carts.reject!{|c| c.weighted_value == cart.weighted_value}
    end
  end
  if carts.length == 1
    pp "#{carts[0].col},#{carts[0].row}"
    exit
  else
    carts.each do |cart|
      cart.moved = false
    end
  end
end
