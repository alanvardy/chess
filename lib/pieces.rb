class Piece
  def move

  end
end

class King < Piece
  def initialize(color, location)
    @moved = 1
    @color = color
    @location = location
    if color == 'white'
      @symbol = 'U+2654'
    else
      @symbol = 'U+265A'
    end
    @moves = [[-1, -1], [0, -1], [1, -1], [-1, 0],
              [-1, 1], [0, 1], [1, 1], [1, 0]]
    @attacks = @moves
  end
end

class Queen < Piece
  def initialize(color, location)
    @moved = 1
    @color = color
    @location = location
    if color == 'white'
      @symbol = 'U+2655'
    else
      @symbol = 'U+265B'
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
    @moved = 1
    @color = color
    @location = location
    if color == 'white'
      @symbol = 'U+2656'
    else
      @symbol = 'U+265C'
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
    @moved = 1
    @color = color
    @location = location
    if color == 'white'
      @symbol = 'U+2657'
    else
      @symbol = 'U+265D'
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
    @moved = 1
    @color = color
    @location = location
    if color == 'white'
      @symbol = 'U+2658'
    else
      @symbol = 'U+265E'
    end
    @moves = [[2, -1], [2, 1], [1, -2], [1, 2], [-1, -2], [-1, 2], [-2, -1], [-2, 1]]
    @attacks = @moves
  end
end

class Pawn < Piece
  def initialize(color, location)
    @moved = 0
    @color = color
    @location = location
    if color == 'white'
      @symbol = 'U+2659'
    else
      @symbol = 'U+265F'
    end
    if color == 'white'
      @first_move
      @moves =
      @attacks =
    else
      @moves =
      @attacks =
    end
  end
end