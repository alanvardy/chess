require_relative 'pieces'

class Board
  attr_accessor :board
  def initialize
    @board = [[" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "," "],]
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
    puts "\n"
    horizontal_line
    @board.each do |row|
      print " | "
      row.each do |square|
        if square == " "
          print square
        else
          print square.icon
        end
        print " | "
      end
      puts ""
      horizontal_line
    end
    puts "\n"
  end

  def horizontal_line
    puts ' -' * 17
  end
end