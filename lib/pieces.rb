class Piece
  def move

  end
end

class King < Piece
  def initialize(color, location)
    @color = color
    @location = location
    if color = white
      @symbol = 'U+2654'
    else
      @symbol = 'U+265A'
    end
    @moves = [[-1, -1], [0, -1], [1, -1], [-1, 0],
              [-1, 1], [0, 1], [1, 1], [1, 0]]
  end
end

class Queen < Piece
  def initialize(color, location)
    @color = color
    @location = location
    if color = white
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
  end
end

class Rook < Piece
  def initialize(color, location)
    @color = color
    @location = location
    if color = white
      @symbol = 'U+2656'
    else
      @symbol = 'U+265C'
    end
    @moves = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
              [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7],
              [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
              [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]]
  end
end

class Bishop < Piece
  def initialize(color, location)
    @color = color
    @location = location
    if color = white
      @symbol = 'U+2657'
    else
      @symbol = 'U+265D'
    end
    @moves = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
              [1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7],
              [-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7],
              [-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]]
  end
end

class Knight < Piece
  def initialize(color, location)
    @color = color
    @location = location
    if color = white
      @symbol = 'U+2658'
    else
      @symbol = 'U+265E'
    end
  end
end

class Pawn < Piece
  def initialize(color, location)
    @color = color
    @location = location
    if color = white
      @symbol = 'U+2659'
    else
      @symbol = 'U+265F'
    end
  end
end