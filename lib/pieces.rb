class Piece
  def move

  end
end

class King < Piece
  def initialize(color, location)
    @color = color
    @location
    if color = white
      @symbol = 'U+2654'
    else
      @symbol = 'U+265A'
    end
  end
end

class Queen < Piece
  def initialize(color, location)
    @color = color
    @location
    if color = white
      @symbol = 'U+2655'
    else
      @symbol = 'U+265B'
    end
  end
end

class Rook < Piece
  def initialize(color, location)
    @color = color
    @location
    if color = white
      @symbol = 'U+2656'
    else
      @symbol = 'U+265C'
    end
  end
end

class Bishop < Piece
  def initialize(color, location)
    @color = color
    @location
    if color = white
      @symbol = 'U+2657'
    else
      @symbol = 'U+265D'
    end
  end
end

class Knight < Piece
  def initialize(color, location)
    @color = color
    @location
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
    @location
    if color = white
      @symbol = 'U+2659'
    else
      @symbol = 'U+265F'
    end
  end
end