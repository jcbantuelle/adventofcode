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

new_keep = {}
keep = {"119676999498"=>112, "129676999498"=>113, "139676999498"=>114, "149676999498"=>115, "159676999498"=>116, "169676999498"=>117, "179676999498"=>118, "189676999498"=>119, "199676999498"=>120, "219676999498"=>138, "229676999498"=>139, "239676999498"=>140, "249676999498"=>141, "259676999498"=>142, "269676999498"=>143, "279676999498"=>144, "289676999498"=>145, "299676999498"=>146, "319676999498"=>164, "329676999498"=>165, "339676999498"=>166, "349676999498"=>167, "359676999498"=>168, "369676999498"=>169, "379676999498"=>170, "389676999498"=>171, "399676999498"=>172, "419676999498"=>190, "429676999498"=>191, "439676999498"=>192, "449676999498"=>193, "459676999498"=>194, "469676999498"=>195, "479676999498"=>196, "489676999498"=>197, "499676999498"=>198, "519676999498"=>216, "529676999498"=>217, "539676999498"=>218, "549676999498"=>219, "559676999498"=>220, "569676999498"=>221, "579676999498"=>222, "589676999498"=>223, "599676999498"=>224, "619676999498"=>242, "629676999498"=>243, "639676999498"=>244, "649676999498"=>245, "659676999498"=>246, "669676999498"=>247, "679676999498"=>248, "689676999498"=>249, "699676999498"=>250, "719676999498"=>268, "729676999498"=>269, "739676999498"=>270, "749676999498"=>271, "759676999498"=>272, "769676999498"=>273, "779676999498"=>274, "789676999498"=>275, "799676999498"=>276, "819676999498"=>294, "829676999498"=>295, "839676999498"=>296, "849676999498"=>297, "859676999498"=>298, "869676999498"=>299, "879676999498"=>300, "889676999498"=>301, "899676999498"=>302, "919676999498"=>320, "929676999498"=>321, "939676999498"=>322, "949676999498"=>323, "959676999498"=>324, "969676999498"=>325, "979676999498"=>326, "989676999498"=>327, "999676999498"=>328}

instructions = inputs[12] + inputs[13]
1.upto(9) do |i|
  1.upto(9) do |j|
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
        pp "#{monad}#{i}#{j} = #{vars['z']}"
        # new_keep["#{monad}#{i}#{j}"] = vars['z']
      end
    end
  end
end

# puts new_keep.invert.invert
