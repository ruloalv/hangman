dictionary = File.read "5desk.txt"
dictionary = dictionary.split("\r\n")	


class Hangman 
	attr_reader :word, :letters, :trys_left, :gamer, :secret_word

	def initialize(name, dictionary)
		@gamer = name
		@board = ["   +---+","   |   |","       |","       |","       |","       |","   ======="]
		@dictionary = dictionary
		@secret_word = dictionary[rand(dictionary.length)-1].upcase

		until @secret_word.length > 4 && @secret_word.length < 13
			@secret_word = @dictionary[rand(@dictionary.length)-1].upcase
		end

		@word = "_" * @secret_word.length
		@letters = []
		@trys_left = 6
	end

	def print_game
		system("clear")
		puts "Player: #{@gamer}"
		print "Guess the word: "
		@word.each_char {|c| print "#{c} "}
		puts ""
		puts "Chossen Letters: #{@letters.join(" ")}"
		puts "Trys Left: #{@trys_left}"

		case trys_left
		when 5
			@board[2] = "   O   |"
		when 4
			@board[3] = "   |   |"
		when 3
			@board[3] = "  /|   |"
		when 2
			@board[3] = "  /|\\  |"
		when 1
			@board[4] = "  /   |"
		when 0
			@board[4] = " /\\   |"
		end

		@board.each do |d|
			puts d
		end
	end

	def play(letter)
		letter = letter.upcase	
		if letter.length == 1
			while (!@word.include? letter) && (!@letters.include? letter) do
				if @secret_word.include? letter
					i = 0
					@secret_word.each_char do |c|
						if letter == c 
							word[i] = c
						end
						i += 1
					end
				else
					@letters.push(letter)
					@trys_left -=1
				end
			end
		else
			puts "Please choose a single letter"
		end
	end
end

puts "Welcome to Hangman game, for beggin the game please enter your name: "
player = gets.chomp
game = Hangman.new(player, dictionary)
game.print_game

until game.trys_left == 0 || (!game.word.include? "_") do
	puts "Guess a new letter: "
	game.play(gets.chomp.upcase)
	game.print_game
end

if game.trys_left == 0 
	puts "Sorry you lose, the word was: #{game.secret_word}"
else
	puts "Great you win"
end