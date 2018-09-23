class Piece
  attr_reader :symbol, :color, :name, :moves
  attr_accessor :location
  # def icon
  #   @symbol
  # end
end

class King < Piece
  def initialize(color, location)
    @name = "king"
    @moved = 1
    @color = color
    @location = location
    if color == "white"
      @symbol = "\u2654"
    else
      @symbol = "\u265A"
    end
    @moves = [[-1, -1], [0, -1], [1, -1], [-1, 0],
              [-1, 1], [0, 1], [1, 1], [1, 0]]
    @attacks = @moves
  end
end

class Queen < Piece
  def initialize(color, location)
    @name = "queen"
    @moved = 1
    @color = color
    @location = location
    if color == "white"
      @symbol = "\u2655"
    else
      @symbol = "\u265B"
    end
    @moves = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
              [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7],
              [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
              [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
              [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
              [1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7],
              [-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7],
              [-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]]
    @attacks = @moves
  end
end

class Rook < Piece
  def initialize(color, location)
    @name = "rook"
    @moved = 1
    @color = color
    @location = location
    if color == "white"
      @symbol = "\u2656"
    else
      @symbol = "\u265C"
    end
    @moves = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
              [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7],
              [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
              [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]]
    @attacks = @moves
  end
end

class Bishop < Piece
  def initialize(color, location)
    @name = "bishop"
    @moved = 1
    @color = color
    @location = location
    if color == "white"
      @symbol = "\u2657"
    else
      @symbol = "\u265D"
    end
    @moves = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
              [1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7],
              [-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7],
              [-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]]
    @attacks = @moves
  end
end

class Knight < Piece
  def initialize(color, location)
    @name = "knight"
    @moved = 1
    @color = color
    @location = location
    if color == "white"
      @symbol = "\u2658"
    else
      @symbol = "\u265E"
    end
    @moves = [[2, -1], [2, 1], [1, -2], [1, 2], [-1, -2], [-1, 2], [-2, -1], [-2, 1]]
    @attacks = @moves
  end
end

class Pawn < Piece
  def initialize(color, location)
    @name = "pawn"
    @moved = 0
    @color = color
    @location = location
    if color == "white"
      @symbol = "\u2659"
    else
      @symbol = "\u265F"
    end
    if color == "white"
      @first_move = [[2, 0], [1, 0]]
      @moves = [[1, 0]]
      @attacks = [[1, -1], [1, 1]]
    else
      @first_move = [[-2, 0], [-1, 0]]
      @moves = [[-1, 0]]
      @attacks = [[-1, -1], [-1, 1]]
    end
  end
end