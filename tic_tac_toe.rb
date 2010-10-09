#!/usr/bin/env ruby

# A program to play an N x N game of Tic-Tac-Toe

class TicTacToe
	class BoardFull < Exception
	end

	class Winner < Exception
		def initialize(winner_name)
			@winner_name = winner_name
		end
		def winner_name
			@winner_name
		end
	end

	def initialize
		# Board depth, 3x3 is classic
		@n = 3

		@board_state = []
		# Create an NxN multi-dimensional array of " "
		@n.times do
			x = []
			@n.times do
				x.push(" ")
			end
			@board_state.push(x)
		end

		# Player names
		@players = {}
	end

	def print_board
		# Column numbers
		header = " "
		(0..@n-1).each do |i|
			header += " #{i}  "
		end
		puts header
		# Top border
		header = "'"
		(0..@n-2).each do |i|
			header += "---|"
		end
		header += "---`"
		puts header
		(0..@n-1).each do |line_number|
			print "|"
			@board_state[line_number].each do |mark|
				print " #{mark} |"
			end
			print " #{line_number}\n"
			# Bottom border
			header = "`"
			(0..@n-2).each do |i|
				header += "---|"
			end
			header += "---'"
			puts header
		end
	end

	def play_game
		puts "Shall we play a game?.... Heck yeah!"
		self.print_board
		sleep 1

		puts "Who's gonna be X?"
		@players["X"] = gets.strip
		puts "And who's going to be O?"
		@players["O"] = gets.strip
		puts "Ok, let's go..."

		turn_number = 0
		loop do
			turn_number += 1

			# Alternate X and O
			if turn_number%2!=0 then
				player="X"
			else
				player="O"
			end

			# Take a position and place it
			begin
				puts "#{@players[player]} (#{player}), give us your position as 'x,y'"
				x,y = gets.chomp.split(',').map{|i| i=i.to_i}
				self.make_a_move(x,y,player)
			rescue
				puts "Not a valid move. Try again"
				self.print_board
				retry
			end

			self.print_board

			# See if there's a winner or if it's a draw
			begin
				self.check_game_state(x,y,player)
			rescue Exception => exception
				if exception.is_a?(TicTacToe::Winner) then
					puts "And the winner is #{exception.winner_name}!"
					Kernel.exit
				end
				if exception.is_a?(TicTacToe::BoardFull) then
					puts "Looks like a draw. Shucks!"
					Kernel.exit
				end
			end
		end
	end

	def make_a_move(x, y, mark)
		# Check the mark's validity
		unless ( (mark=="x") || (mark=="X") || (mark=="o") || (mark=="O") )
			puts 'not a valid mark'
			raise
		end
		# Check the position's validity
		unless(x.is_a?(Integer) && y.is_a?(Integer))
			puts 'not a valid number'
			raise
		end
		unless( (x>=0)&&(x<=@n-1) && (y>=0)&&(y<=@n-1) )
			puts 'position not in range'
			raise
		end
		# Check that the spot hasn't been taken
		unless(@board_state[y][x] == " ")
			puts 'already a marker there'
			raise
		end
		@board_state[y][x] = mark
	end

	def check_game_state(x,y,mark)
		# Is there a winner
		# Row?
		(0..@n-1).each do |i|
			if (@board_state[y][i] != mark) then
				break
			end
			if (i == @n-1) then
				raise TicTacToe::Winner.new(@players[mark])
			end
		end
		# Column?
		(0..@n-1).each do |i|
			if (@board_state[i][x] != mark) then
				break
			end
			if (i == @n-1) then
				raise TicTacToe::Winner.new(@players[mark])
			end
		end
		# Up-down diagonal
		(0..@n-1).each do |i|
			if (@board_state[i][i] != mark) then
				break
			end
			if (i == @n-1) then
				raise TicTacToe::Winner.new(@players[mark])
			end
		end
		# Down-up diagonal
		(0..@n-1).each do |i|
			if (@board_state[i][(@n-1)-i] != mark) then
				break
			end
			if (i == @n-1) then
				raise TicTacToe::Winner.new(@players[mark])
			end
		end

		# Is the board full?
		number_of_spots = @n*@n
		taken_spots = 0
		@board_state.each do |row|
			row.each do |spot|
				if (spot != " ") then
					taken_spots += 1
				end
			end
		end
		if taken_spots >= number_of_spots then
			# Board is full
			raise TicTacToe::BoardFull
		end
	end
end

t = TicTacToe.new
t.play_game
