#!/usr/bin/env ruby

# Tell knockknock jokes.
#  Prompt the user
#  Get the name
#  Tell a joke

jokes = [
	["Phillip", "my bag with candy!"],
	["Banana", "Waffle"]
]

jokes.each do |joke|
	puts "Knock Knock"
	
	while (gets.strip != "Who's there?") do
		puts "What choo talkin' bout' Willis!?"
		sleep 1
		puts "Knock Knock"
	end

#	whos_there = gets.strip
#	unless (whos_there == "Who's there?") then
#		puts "What choo talkin' bout' Willis!?"
#	end

	puts joke[0]

#	name = gets.strip
#	unless (name == "#{joke[0]} who?") then
#		puts "Try again"
#		puts joke[0]
#	end
	while (gets.strip != "#{joke[0]} who?") do
		puts "Try again!"
		sleep 1
		puts "#{joke[0]}"
	end
	#       vvvv        vvvvv     String Interpolation
	puts "#{joke[0]} #{joke[1]}"
	sleep 1
end
