require_relative 'pieces'
require_relative 'players'

class Board
  attr_accessor :board, :selected_piece, :selected_coordinates, :player_turn,
                :white_player, :black_player
  attr_reader :errors
  def initialize
    @errors = []
    @turn_complete = true
    clear_selection
    @board = [[" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "]]
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
    clear_screen
    row_number = ["1", "2", "3", "4", "5", "6", "7", "8"]
    column_letter = ["a", "b", "c", "d", "e", "f", "g", "h"]
    puts "\n"
    horizontal_line
    yref = 0
    @board.each do |row|
      print " #{row_number[yref]} |"
      xref = 0
      row.each do |square|
        if square == " "
          print "   "
        elsif selected_square?(yref, xref)
          print "|#{square.symbol}|"
        else
          print " #{square.symbol} "
        end
        print "|"
        xref += 1
      end
      yref += 1
      puts ""
      horizontal_line
    end
    print "     "
    column_letter.each do |letter|
      print letter
      print "   "
    end
    puts "\n\n"
    print_errors
  end

  def horizontal_line
    print "  "
    puts ' -' * 17
  end

  def print_errors
    while @errors.length > 0
      puts @errors.pop
    end
  end

  def selected_square?(y, x)
    if @selected_coordinates.nil?
      false
    elsif @selected_coordinates[0] == y && @selected_coordinates[1] == x
      true
    else
      false
    end
  end

  def select_square
    loop do
      print_errors
      y, x = input_coordinates("#{@player_turn.name}: Select piece")
      next if y.nil?
      selected = @board[y][x]
      if selected == " "
        @errors << "You selected a blank square"
      elsif selected.color == @player_turn.color
        @selected_piece = selected
        @selected_coordinates = [y, x]
        puts "You have selected #{selected.color} #{selected.name}"
        return
      else
        puts "You need to choose a #{@player_turn.color} piece"
      end
    end
  end

  def input_coordinates(text)
    result = ""
    loop do
      result = input(text + " (i.e. b5):")
      break if result =~ /^[a-h][1-8]$/
      @errors << "Bad input!"
      return nil
    end
    y, x = convert(result)
    return y, x
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

  def start
    add_pieces
    create_players
    game
  end

  def create_players
    name = input("Enter name white player: ")
    @white_player = Player.new(name, "white")
    name = input("Enter name black player: ")
    @black_player = Player.new(name, "black")
  end

  def input(text)
    print text
    gets.chomp
  end

  def game
    until won? do
      change_player
      display
      select_square
      display
      move
    end
    declare_winner
  end

  def won?
    return false if has_king?("white") && has_king?("black")
    true
  end

  def has_king?(color)
    @board.each do |row|
      row.each do |square|
        if square.is_a?(Piece)
          return true if square.name == "king" &&
          square.color == color
        end
      end
    end
    false
  end

  def declare_winner
    puts "#{@white_player.name} has won the game!" unless has_king?("black")
    puts "#{@black_player.name} has won the game!" unless has_king?("white")
  end

  def change_player
    if @player_turn == @white_player && @turn_complete
      @player_turn = @black_player
      @turn_complete = false
    elsif @turn_complete
      @player_turn = @white_player
      @turn_complete = false
    end
  end

  def move
    if @selected_piece.nil?
      @errors << "There is nothing here!"
      clear_selection
    else
      y, x = input_coordinates("Choose square to move to")
      if valid_move?(y, x)
        move_piece(y,x)
      else
        clear_selection
      end
    end
  end

  def clear_selection
    @selected_piece = nil
    @selected_coordinates = nil
  end

  def move_piece(y, x)
    @board[y][x] = @selected_piece
    @board[y][x].location = [y, x]
    @board[selected_coordinates[0]][selected_coordinates[1]] = " "
    @turn_complete = true
    clear_selection
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