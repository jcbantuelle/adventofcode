require 'pp'

class Blueprint
  attr_accessor :id, :requirements, :bots, :materials, :max_ore, :max_clay, :max_obsidian

  def initialize(id, requirements, bots, materials)
    @id = id
    @requirements = requirements
    @bots = bots
    @materials = materials
    @max_ore = [@requirements[:ore], @requirements[:clay], @requirements[:obsidian][0], @requirements[:geode][0]].max
    @max_clay = @requirements[:obsidian][1]
    @max_obsidian = @requirements[:geode][1]
  end

  def execute
    material_generation = generate_materials
    blueprints = []
    if @materials[:ore] >= @requirements[:geode][0] && @materials[:obsidian] >= @requirements[:geode][1]
      new_bots = @bots.clone
      new_bots[:geode] += 1
      new_materials = material_generation.clone
      new_materials[:ore] -= @requirements[:geode][0]
      new_materials[:obsidian] -= @requirements[:geode][1]
      b = Blueprint.new(@id, @requirements, new_bots, new_materials)
      unless $seen[b.seen_index]
        $seen[b.seen_index] = true
        blueprints << b
      end
    elsif @materials[:ore] >= @requirements[:obsidian][0] && @materials[:clay] >= @requirements[:obsidian][1] && @bots[:obsidian] < @max_obsidian
      new_bots = @bots.clone
      new_bots[:obsidian] += 1
      new_materials = material_generation.clone
      new_materials[:ore] -= @requirements[:obsidian][0]
      new_materials[:clay] -= @requirements[:obsidian][1]
      b = Blueprint.new(@id, @requirements, new_bots, new_materials)
      unless $seen[b.seen_index]
        $seen[b.seen_index] = true
        blueprints << b
      end
      if @materials[:ore] >= @requirements[:clay] && @bots[:clay] < @max_clay
        new_bots = @bots.clone
        new_bots[:clay] += 1
        new_materials = material_generation.clone
        new_materials[:ore] -= @requirements[:clay]
        b = Blueprint.new(@id, @requirements, new_bots, new_materials)
        unless $seen[b.seen_index]
          $seen[b.seen_index] = true
          blueprints << b
        end
      end
      if @materials[:ore] >= @requirements[:ore] && @bots[:ore] < @max_ore
        new_bots = @bots.clone
        new_bots[:ore] += 1
        new_materials = material_generation.clone
        new_materials[:ore] -= @requirements[:ore]
        b = Blueprint.new(@id, @requirements, new_bots, new_materials)
        unless $seen[b.seen_index]
          $seen[b.seen_index] = true
          blueprints << b
        end
      end
      if @bots[:ore] < @max_ore
        new_bots = @bots.clone
        new_materials = material_generation.clone
        b = Blueprint.new(@id, @requirements, new_bots, new_materials)
        unless $seen[b.seen_index]
          $seen[b.seen_index] = true
          blueprints << b
        end
      end
    elsif @materials[:ore] >= @requirements[:clay] && @bots[:clay] < @max_clay
      new_bots = @bots.clone
      new_bots[:clay] += 1
      new_materials = material_generation.clone
      new_materials[:ore] -= @requirements[:clay]
      b = Blueprint.new(@id, @requirements, new_bots, new_materials)
      unless $seen[b.seen_index]
        $seen[b.seen_index] = true
        blueprints << b
      end
      if @materials[:ore] >= @requirements[:ore] && @bots[:ore] < @max_ore
        new_bots = @bots.clone
        new_bots[:ore] += 1
        new_materials = material_generation.clone
        new_materials[:ore] -= @requirements[:ore]
        b = Blueprint.new(@id, @requirements, new_bots, new_materials)
        unless $seen[b.seen_index]
          $seen[b.seen_index] = true
          blueprints << b
        end
      end
      if @bots[:ore] < @max_ore
        new_bots = @bots.clone
        new_materials = material_generation.clone
        b = Blueprint.new(@id, @requirements, new_bots, new_materials)
        unless $seen[b.seen_index]
          $seen[b.seen_index] = true
          blueprints << b
        end
      end
    elsif @materials[:ore] >= @requirements[:ore] && @bots[:ore] < @max_ore
      new_bots = @bots.clone
      new_bots[:ore] += 1
      new_materials = material_generation.clone
      new_materials[:ore] -= @requirements[:ore]
      b = Blueprint.new(@id, @requirements, new_bots, new_materials)
      unless $seen[b.seen_index]
        $seen[b.seen_index] = true
        blueprints << b
      end
      if @bots[:ore] < @max_ore
        new_bots = @bots.clone
        new_materials = material_generation.clone
        b = Blueprint.new(@id, @requirements, new_bots, new_materials)
        unless $seen[b.seen_index]
          $seen[b.seen_index] = true
          blueprints << b
        end
      end
    else
      new_bots = @bots.clone
      new_materials = material_generation.clone
      b = Blueprint.new(@id, @requirements, new_bots, new_materials)
      unless $seen[b.seen_index]
        $seen[b.seen_index] = true
        blueprints << b
      end
    end
    blueprints
  end

  def generate_materials
    new_materials = @materials.clone
    new_materials[:ore] += @bots[:ore]
    new_materials[:clay] += @bots[:clay]
    new_materials[:obsidian] += @bots[:obsidian]
    new_materials[:geode] += @bots[:geode]
    new_materials
  end

  def seen_index
    @bots.values.join(',') + @materials.values.join(',')
  end

  def self.parse_line(line)
    values = /[^\d]+(\d+)[^\d]+(\d+)[^\d]+(\d+)[^\d]+([\d+])[^\d]+(\d+)[^\d]+(\d)[^\d]+(\d+)/.match(line)[1..-1].map(&:to_i)
    [values[0], {
      ore: values[1],
      clay: values[2],
      obsidian: [values[3],values[4]],
      geode: [values[5],values[6]]
    }, {
      ore: 1,
      clay: 0,
      obsidian: 0,
      geode: 0
    }, {
      ore: 0,
      clay: 0,
      obsidian: 0,
      geode: 0
    }]
  end
end

start = Time.now
pp File.open('input.txt').each_line.map{ |line|
  blueprints = [Blueprint.new(*Blueprint.parse_line(line))]
  id = blueprints.first.id
  pp id
  $seen = {}
  1.upto(24) do |i|
    blueprints = blueprints.map{|b| b.execute}.flatten
    pp "    #{i}"
  end
  blueprints.map{|b| b.materials[:geode]}.max * id
}.inject(&:+)
pp "Finished in: #{Time.now - start}s"
