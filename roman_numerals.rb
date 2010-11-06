#!/usr/bin/env ruby

=begin
Take a number, convert to really-old-style Roman Numerals (no subtraction).
=end

def romanize(number)
  output = ""
  divisors = [ ["M", 1000], ["D", 500], ["C", 100], ["L", 50], ["X", 10], ["V", 5], ["I", 1] ]
  divisors.each do |name,div|
    if (number/div > 0) then
      output += name*(number/div)
      number = number % div
    end
  end

  return output
end

loop do
  print("Number: ")
  number = gets.chomp.to_i
  puts "Romanized: #{romanize(number)}"
end
