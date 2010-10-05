#!/usr/bin/env ruby

# Tell knockknock jokes.
#  Prompt the user
#  Get the name
#  Tell a joke

jokes = [
	["Phillip", "my bag with candy!"]
]

jokes.each do |joke|
	puts "Knock Knock"
	whos_there = gets.strip
	puts joke[0]
	name = gets.strip
	puts "#{joke[0]} #{joke[1]}"
	sleep 1
end
