require 'pp'

instructions = {}

File.foreach('input.txt') do |line|
  instruction = line.chomp.split(' ')
  step = instruction[7]
  dependency = instruction[1]
  instructions[step] ||= []
  instructions[step].push(dependency)
end

(instructions.values.flatten.uniq - instructions.keys).each do |step|
  instructions[step] = []
end

order = ''
idle_workers = Array.new(5, 0)
active_workers = Array.new
timer = 0

while !instructions.empty? || !active_workers.empty? do
  completed_steps = []
  finished_workers = []
  active_workers.each_with_index do |worker, index|
    if worker[:time_left] == 0
      completed_steps.push(worker[:step]) if worker[:time_left] == 0
      finished_workers.push(index)
      instructions.each do |step, instruction|
        instruction.delete(worker[:step])
      end
    end
  end
  order += completed_steps.sort.join('')
  finished_workers.each do |worker_index|
    active_workers[worker_index] = nil
    idle_workers.push(0)
  end
  active_workers.compact!

  next_steps = instructions.select{|step,dependencies|
    dependencies.empty?
  }.keys.sort

  next_steps.each do |step|
    unless idle_workers.first.nil?
      idle_workers.shift
      active_workers.push({
        step: step,
        time_left: 60+(step.ord-64)
      })
      instructions.delete(step)
    end
  end

  active_workers.each do |worker|
    worker[:time_left] -= 1
  end
  timer += 1
end

pp timer-1
