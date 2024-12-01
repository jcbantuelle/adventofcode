require 'pp'

$conversions = {}
$tally_memo = {}
tally = {}
insertions = 40
polymer = nil

def merge_tallies(tally1, tally2)
  new_tally = tally1.dup
  tally2.each do |letter, frequency|
    new_tally[letter] = 0 if new_tally[letter].nil?
    new_tally[letter] += frequency
  end
  new_tally
end

def expand(conversion, depth)
  memo = $tally_memo[conversion[:molecule]+depth.to_s]
  return memo unless memo.nil?
  if depth > 0
    tally_left = expand($conversions[conversion[:molecule][0]+conversion[:insertion]], depth-1)
    tally_right = expand($conversions[conversion[:insertion]+conversion[:molecule][1]], depth-1)
    tally = merge_tallies(tally_left, tally_right)
    tally[conversion[:insertion]] = 0 if tally[conversion[:insertion]].nil?
    tally[conversion[:insertion]] += 1
    $tally_memo[conversion[:molecule]+depth.to_s] = tally
    return tally
  else
    return {}
  end
end

File.foreach('input.txt') do |line|
  line = line.chomp
  if line.include?('-')
    conversion = line.split(' -> ')
    $conversions[conversion[0]] = {
      molecule: conversion[0],
      insertion: conversion[1]
    }
  elsif !line.empty?
    polymer = line
  end
end

start = Time.now
polymer.each_char.to_a.each_with_index do |letter, index|
  tally[letter] = 0 if tally[letter].nil?
  tally[letter] += 1
  unless polymer[index+1].nil?
    conversion = $conversions[letter+polymer[index+1]]
    tally_subcount = expand(conversion, insertions)
    tally = merge_tallies(tally, tally_subcount)
  end
end
pp Time.now-start

frequency = tally.to_a.sort_by{|tally| tally[1]}
pp frequency.last[1] - frequency.first[1]
