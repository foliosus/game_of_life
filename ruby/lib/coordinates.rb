class Coordinates
  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    @x = bound_coordinate(x)
    @y = bound_coordinate(y)
  end

  #TODO all of these need to know about the edges of the grid
  def left
    Coordinates.new(x-1, y)
  end

  def right
    Coordinates.new(x+1, y)
  end

  def top
    Coordinates.new(x, y-1)
  end

  def bottom
    Coordinates.new(x, y+1)
  end

  def top_left
    Coordinates.new(x-1, y-1)
  end

  def top_right
    Coordinates.new(x+1, y-1)
  end

  def bottom_left
    Coordinates.new(x-1, y+1)
  end

  def bottom_right
    Coordinates.new(x+1, y+1)
  end

  private def bound_coordinate(x_or_y)
    if x_or_y < 0
      0
    elsif x_or_y >= Grid.size
      Grid.size - 1 # Grid.size isn't zero-offset
    else
      x_or_y
    end
  end
end