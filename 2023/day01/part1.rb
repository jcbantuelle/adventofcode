require 'pp'

calibration_sum = 0
File.open('input.txt').each_line{ |calibration|
  digits = calibration.chomp.scan(/[\d]/)
  calibration_sum += (digits.first + digits.last).to_i
}

pp calibration_sum
