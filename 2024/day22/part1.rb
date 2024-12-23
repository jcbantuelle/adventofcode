secrets = File.open('input.txt').map{ |secret|
  secret.chomp.to_i
}

2000.times { |_|
  secrets.map!{ |secret|
    secret = (secret ^ (secret * 64)) % 16777216
    secret = (secret ^ (secret / 32)) % 16777216
    (secret ^ (secret * 2048)) % 16777216
  }
}

puts secrets.inject(&:+)
