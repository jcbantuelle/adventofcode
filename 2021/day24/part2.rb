require 'pp'

inputs = []
next_set = nil
File.foreach('input.txt') do |line|
  line = line.chomp.split(' ')
  if line.include?('inp')
    inputs.push(next_set) unless next_set.nil?
    next_set = [line]
  else
    next_set.push(line)
  end
end
inputs.push(next_set)

keep = {"114111436121"=>112, "124111436121"=>113, "134111436121"=>114, "144111436121"=>115, "154111436121"=>116, "164111436121"=>117, "174111436121"=>118, "184111436121"=>119, "194111436121"=>120, "214111436121"=>138, "224111436121"=>139, "234111436121"=>140, "244111436121"=>141, "254111436121"=>142, "264111436121"=>143, "274111436121"=>144, "284111436121"=>145, "294111436121"=>146, "314111436121"=>164, "324111436121"=>165, "334111436121"=>166, "344111436121"=>167, "354111436121"=>168, "364111436121"=>169, "374111436121"=>170, "384111436121"=>171, "394111436121"=>172, "414111436121"=>190, "424111436121"=>191, "434111436121"=>192, "444111436121"=>193, "454111436121"=>194, "464111436121"=>195, "474111436121"=>196, "484111436121"=>197, "494111436121"=>198, "514111436121"=>216, "524111436121"=>217, "534111436121"=>218, "544111436121"=>219, "554111436121"=>220, "564111436121"=>221, "574111436121"=>222, "584111436121"=>223, "594111436121"=>224, "614111436121"=>242, "624111436121"=>243, "634111436121"=>244, "644111436121"=>245, "654111436121"=>246, "664111436121"=>247, "674111436121"=>248, "684111436121"=>249, "694111436121"=>250, "714111436121"=>268, "724111436121"=>269, "734111436121"=>270, "744111436121"=>271, "754111436121"=>272, "764111436121"=>273, "774111436121"=>274, "784111436121"=>275, "794111436121"=>276, "814111436121"=>294, "824111436121"=>295, "834111436121"=>296, "844111436121"=>297, "854111436121"=>298, "864111436121"=>299, "874111436121"=>300, "884111436121"=>301, "894111436121"=>302, "914111436121"=>320, "924111436121"=>321, "934111436121"=>322, "944111436121"=>323, "954111436121"=>324, "964111436121"=>325, "974111436121"=>326, "984111436121"=>327, "994111436121"=>328}
new_keep = {}

instructions = inputs[12] + inputs[13]
1.upto(9) do |i|
  1.upto(9) do |j|
    # 1.upto(9) do |k|
      # 1.upto(9) do |l|
        keep.each do |monad, z|
          parts = [i,j]
          vars = {
            'w' => 0,
            'x' => 0,
            'y' => 0,
            'z' => z
          }
          instructions.each do |instruction|
            if instruction[0] == 'inp'
              vars[instruction[1]] = parts.shift
            else
              second_param = instruction[2]
              if %w(w x y z).include?(second_param)
                second_param = vars[second_param]
              else
                second_param = second_param.to_i
              end
              if instruction[0] == 'add'
                vars[instruction[1]] += second_param
              elsif instruction[0] == 'mul'
                vars[instruction[1]] *= second_param
              elsif instruction[0] == 'div'
                vars[instruction[1]] /= second_param
              elsif instruction[0] == 'mod'
                vars[instruction[1]] %= second_param
              elsif instruction[0] == 'eql'
                vars[instruction[1]] = vars[instruction[1]] == second_param ? 1 : 0
              end
            end
          end
          if vars['z'] == 0
            # pp "#{monad}#{i}#{j} = #{vars['z']}"
            new_keep["#{monad}#{i}#{j}"] = vars['z']
          end
        end
      # end
    # end
  end
end

pp new_keep
# smallest = {}
# new_keep.each do |monad, value|
#   smallest[value] = monad if smallest[value].nil?
# end
# puts smallest.invert
