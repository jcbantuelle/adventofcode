secrets = File.open('input.txt').map{ |secret|
  secret.chomp.to_i
}
secrets_count = secrets.length

sequence_keys = []
sequences = []
previous = []

secrets_count.times do |i|
  sequence_keys << {}
  sequences << []
  previous << nil
end

2000.times { |i|
  secrets_count.times { |j|
    secret = secrets[j]
    secret = (secret ^ (secret * 64)) % 16777216
    secret = (secret ^ (secret / 32)) % 16777216
    secret = (secret ^ (secret * 2048)) % 16777216
    last_digit = secret.to_s[-1].to_i
    if i > 0
      change = last_digit - previous[j]
      sequences[j] << change
      sequences[j].shift if i > 4
      if i > 3
        sequence = sequences[j].join(',')
        sequence_keys[j][sequence] = last_digit if sequence_keys[j][sequence].nil?
      end
    end
    previous[j] = last_digit
    secrets[j] = secret
  }
}

buys = {}

sequence_keys.map(&:keys).flatten.uniq.each { |seq|
  buys[seq] = sequence_keys.reduce(0) { |sum, sequence|
    sum + (sequence[seq].nil? ? 0 : sequence[seq])
  }
}

puts buys.to_a.sort_by{|b| b[1]}[-1][1]
