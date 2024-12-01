require 'pp'

digits = nil

File.foreach('input.txt') do |line|
  line = line.chomp
  loop do
    object_scan = line.scan(/{[^}{]*}/)
    break if object_scan.size == 0
    object_scan.each do |object_match|
      if object_match.include?(':"red"')
        line.sub!(object_match, '0')
      else
        sub_digits = object_match.scan(/(\-?\d+)/).flatten.map(&:to_i).inject(&:+)
        line.sub!(object_match, sub_digits.to_s)
      end
    end
  end
  digits = line.scan(/(\-?\d+)/)
  break
end

pp digits.flatten.map(&:to_i).inject(&:+)
