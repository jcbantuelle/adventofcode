require 'pp'

gates = {}

File.foreach('input.txt') do |line|
  instruction = line.chomp
  starter = instruction.match(/^(\d+)\s\->\s([a-z]+)$/)
  if starter.nil?
    two_gate = instruction.match(/^([a-z]+)\s([A-Z]+)\s([a-z]+)\s\->\s([a-z]+)$/)
    if two_gate.nil?
      one_gate_left = instruction.match(/^(\d+)\s([A-Z]+)\s([a-z]+)\s\->\s([a-z]+)$/)
      if one_gate_left.nil?
        one_gate_right = instruction.match(/^([a-z]+)\s([A-Z]+)\s(\d+)\s\->\s([a-z]+)$/)
        if one_gate_right.nil?
          not_gate = instruction.match(/^([A-Z]+)\s([a-z]+)\s\->\s([a-z]+)$/)
          if not_gate.nil?
            direct = instruction.match(/^([a-z]+)\s\->\s([a-z]*)$/)
            gates[direct[2]] = {
              dependencies: [
                direct[1]
              ],
              params: [
                direct[1]
              ],
              instruction: 'NOOP'
            }
          else
            gates[not_gate[3]] = {
              dependencies: [
                not_gate[2]
              ],
              params: [
                not_gate[2]
              ],
              instruction: not_gate[1]
            }
          end
        else
          gates[one_gate_right[4]] = {
            dependencies: [
              one_gate_right[1],
              nil
            ],
            params: [
              one_gate_right[1],
              one_gate_right[3].to_i,
            ],
            instruction: one_gate_right[2]
          }
        end
      else
        gates[one_gate_left[4]] = {
          dependencies: [
            nil,
            one_gate_left[3]
          ],
          params: [
            one_gate_left[1].to_i,
            one_gate_left[3]
          ],
          instruction: one_gate_left[2]
        }
      end
    else
      gates[two_gate[4]] = {
        dependencies: [
          two_gate[1],
          two_gate[3]
        ],
        params: [
          two_gate[1],
          two_gate[3]
        ],
        instruction: two_gate[2]
      }
    end
  else
    gates[starter[2]] = {
      dependencies: [],
      value: starter[1].to_i
    }
  end
end

while gates['a'][:value].nil?
  gates.each do |gate, configuration|
    next if configuration[:value]
    deletions = []
    configuration[:dependencies].each_with_index do |dependency, index|
      next if dependency.nil?
      if gates[dependency][:value]
        configuration[:params][index] = gates[dependency][:value]
        deletions.push(index)
      end
    end
    deletions.each do |deletion|
      configuration[:dependencies][deletion] = nil
    end
    if configuration[:dependencies].compact.empty?
      if configuration[:instruction] == 'NOOP'
        configuration[:value] = configuration[:params][0]
      elsif configuration[:instruction] == 'NOT'
        configuration[:value] = ~configuration[:params][0]
      elsif configuration[:instruction] == 'LSHIFT'
        configuration[:value] = configuration[:params][0] << configuration[:params][1]
      elsif configuration[:instruction] == 'RSHIFT'
        configuration[:value] = configuration[:params][0] >> configuration[:params][1]
      elsif configuration[:instruction] == 'AND'
        configuration[:value] = configuration[:params][0] & configuration[:params][1]
      elsif configuration[:instruction] == 'OR'
        configuration[:value] = configuration[:params][0] | configuration[:params][1]
      end
    end
  end
end

pp gates['a'][:value]
