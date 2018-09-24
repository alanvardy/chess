require_relative 'pieces'
require_relative 'players'

class Board
  attr_accessor :board, :selected_piece, :selected_coordinates
  def initialize
    @errors = []
    @selected_piece = nil
    @selected_coordinates = nil
    @board = [[" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "]]
    add_pieces
  end

  def add_pieces
    @board[0][4] = King.new('black', [0, 4])
    @board[7][4] = King.new('white', [7, 4])
    @board[0][3] = Queen.new('black', [0, 3])
    @board[7][3] = Queen.new('white', [7, 3])
    @board[0][2] = Bishop.new('black', [0, 2])
    @board[0][5] = Bishop.new('black', [0, 5])
    @board[7][2] = Bishop.new('white', [7, 2])
    @board[7][5] = Bishop.new('white', [7, 5])
    @board[0][0] = Rook.new('black', [0, 0])
    @board[0][7] = Rook.new('black', [0, 7])
    @board[7][0] = Rook.new('white', [7, 0])
    @board[7][7] = Rook.new('white', [7, 7])
    @board[0][1] = Knight.new('black', [0, 1])
    @board[0][6] = Knight.new('black', [0, 6])
    @board[7][1] = Knight.new('white', [7, 1])
    @board[7][6] = Knight.new('white', [7, 6])
    @board[1][0] = Pawn.new('black', [1, 0])
    @board[1][1] = Pawn.new('black', [1, 1])
    @board[1][2] = Pawn.new('black', [1, 2])
    @board[1][3] = Pawn.new('black', [1, 3])
    @board[1][4] = Pawn.new('black', [1, 4])
    @board[1][5] = Pawn.new('black', [1, 5])
    @board[1][6] = Pawn.new('black', [1, 6])
    @board[1][7] = Pawn.new('black', [1, 7])
    @board[6][0] = Pawn.new('white', [6, 0])
    @board[6][1] = Pawn.new('white', [6, 1])
    @board[6][2] = Pawn.new('white', [6, 2])
    @board[6][3] = Pawn.new('white', [6, 3])
    @board[6][4] = Pawn.new('white', [6, 4])
    @board[6][5] = Pawn.new('white', [6, 5])
    @board[6][6] = Pawn.new('white', [6, 6])
    @board[6][7] = Pawn.new('white', [6, 7])
  end

  def display
    row_number = ["1", "2", "3", "4", "5", "6", "7", "8"]
    column_letter = ["a", "b", "c", "d", "e", "f", "g", "h"]
    puts "\n"
    horizontal_line
    counter = 0
    @board.each do |row|
      print " #{row_number[counter]} | "
      row.each do |square|
        if square == " "
          print square
        else
          print square.symbol
        end
        print " | "
      end
      counter += 1
      puts ""
      horizontal_line
    end
    print "     "
    column_letter.each do |letter|
      print letter
      print "   "
    end
    puts "\n\n"
    while @errors.length > 0
      puts @errors.pop
    end
  end

  def horizontal_line
    print "  "
    puts ' -' * 17
  end

  def select_square
    loop do
      y, x = input_coordinates("#{@player_turn.name}: Select piece")
      return if y.nil?
      if @board[y][x].color == @player_turn.color
        @selected_piece = @board[y][x]
        @selected_coordinates = [y, x]
        identify(y, x)
        return
      else
        puts "You need to choose a #{@player_turn.color} piece"
      end
    end
  end

  def input_coordinates(text)
    result = ""
    loop do
      print text
      print " (i.e. b5) or c to cancel: "
      result = gets.chomp
      break if result =~ /^[a-h][1-8]$/ || result == "c"
      @errors << "Bad input!"
      return nil
    end
    if result == "c"
      return nil
    else
      y, x = convert(result)
      return y, x
    end
  end

  def convert(string)
    grid_map = {"a" => 0, "b" => 1, "c" => 2, "d" => 3,
                "e" => 4, "f" => 5, "g" => 6, "h" => 7,
                "1" => 0, "2" => 1, "3" => 2, "4" => 3,
                "5" => 4, "6" => 5, "7" => 6, "8" => 7}
    x = grid_map[string[0]]
    y = grid_map[string[1]]
    return y, x
  end

  def identify(y, x)
    square = @board[y][x]
    if square == " "
      @errors << "You have selected nothing"
    else
      puts "You have selected #{square.color} #{square.name}"
    end
  end

  def start
    create_players
    game
  end

  def create_players
    print "Enter name white player: "
    name = gets.chomp
    @white_player = Player.new(name, "white")
    print "Enter name black player: "
    name = gets.chomp
    @black_player = Player.new(name, "black")
    @player_turn = @white_player
  end

  def game
    loop do
      display
      select_square
      clear_screen
      display
      move
      clear_screen
      change_player
    end
  end

  def change_player
    if @player_turn == @white_player
      @player_turn = @black_player
    else
      @player_turn = @white_player
    end
  end

  def move
    if @selected_piece == nil
      @errors << "You need to select a square first"
    elsif @selected_piece == " "
      @errors << "There is nothing here!"
    else
      y, x = input_coordinates("Choose square to move to")
      if valid_move?(y, x)
        @board[y][x] = @selected_piece
        @board[y][x].location = [y, x]
        @board[selected_coordinates[0]][selected_coordinates[1]] = " "
        @selected_piece = nil
        @selected_coordinates = nil
      else
        @selected_piece = nil
        @selected_coordinates = nil
      end
    end
  end

  def valid_move?(y, x)
    @selected_piece.moves.each do |move|
      valid_y = @selected_piece.location[0] + move[0]
      valid_x = @selected_piece.location[1] + move[1]
      return true if y == valid_y && x == valid_x
    end
    @errors << "Invalid move for #{@selected_piece.name}"
    return false
  end

  def clear_screen
    puts "\e[H\e[2J"
  end
end
