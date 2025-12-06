puts File.open('input.txt').reduce(0) { |joltage, bank|
  batteries = bank.chomp.chars.map(&:to_i)
  max_joltage = ""
  12.downto(1) do |joltage_position|
    9.downto(1) do |i|
      max_battery_position = batteries.index(i)
      unless max_battery_position.nil? or max_battery_position > batteries.length - joltage_position
        max_joltage += batteries[max_battery_position].to_s
        batteries = batteries[max_battery_position+1..-1]
        break
      end
    end
  end
  joltage += max_joltage.to_i
}
