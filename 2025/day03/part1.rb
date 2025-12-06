puts File.open('input.txt').reduce(0) { |joltage, bank|
  batteries = bank.chomp.chars.map(&:to_i)
  9.downto(1) do |i|
    left_battery_position = batteries.index(i)
    unless left_battery_position.nil? or left_battery_position == batteries.length - 1
      right_battery = batteries[left_battery_position+1..-1].max
      max_joltage = "#{batteries[left_battery_position]}#{right_battery}".to_i
      joltage += max_joltage
      break
    end
  end
  joltage
}
