require_relative 'pieces'

class Board
  attr_accessor :board, :selected_piece, :selected_coordinates
  def initialize
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
    @board[0][1] = Knight.new('black', [0, 0])
    @board[0][6] = Knight.new('black', [0, 7])
    @board[7][1] = Knight.new('white', [7, 0])
    @board[7][6] = Knight.new('white', [7, 7])
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
    row_number = ["8", "7", "6", "5", "4", "3", "2", "1"]
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
  end

  def horizontal_line
    print "  "
    puts ' -' * 17
  end

  def select
    x, y = input_coordinates("Select square")
    @selected_piece = @board[y][x]
    @selected_coordinates = [x, y]
    identify(x, y)

  end

  def input_coordinates(text)
    print text
    print " (i.e. b5) or c to cancel: "
    result = gets.chomp
    return if result == "c"
    x, y = convert(result)
    return x, y
  end

  def convert(string)
    grid_map = {"a" => 0, "b" => 1, "c" => 2, "d" => 3,
                "e" => 4, "f" => 5, "g" => 6, "h" => 7,
                "1" => 7, "2" => 6, "3" => 5, "4" => 4,
                "5" => 3, "6" => 2, "7" => 1, "8" => 0}
    x = grid_map[string[0]]
    y = grid_map[string[1]]
    return x, y
  end

  def identify(x, y)
    square = @board[y][x]
    if square == " "
      puts "You have selected nothing"
    else
      puts "You have selected #{square.color} #{square.name}"
    end
  end

  def start
    game

  end

  def game
    loop do
      display
      select
      move
    end
  end

  def move
    if @selected_piece == nil
      puts "You need to select a square first"
    elsif @selected_piece == " "
      puts "There is nothing here!"
    else
      x, y = input_coordinates("Choose square to move to")
      @board[y][x] = @selected_piece
      @board[y][x].location = [x, y]
      @board[selected_coordinates[1]][selected_coordinates[0]] = " "
      @selected_piece = nil
      @selected_coordinates = nil
    end
  end
end
