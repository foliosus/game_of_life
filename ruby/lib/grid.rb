class Grid
  include Enumerable

  def self.size
    50
  end

  def self.next_state(grid)
    Grid.new(grid)
  end

  # Initialize a square grid of cells that is size x size
  def initialize(prior_grid = nil)
    @cells = Array.new(Grid.size) { Array.new(Grid.size) }
    Grid.size.times do |row_index|
      Grid.size.times do |column_index|
        coordinates = Coordinates.new(row_index, column_index)
        new_state = if prior_grid
          old_cell = prior_grid.lookup(coordinates)
          old_cell.next_generation_state(prior_grid.neighbors_for(coordinates))
        else
          Cell.random_state
        end
        @cells[row_index][column_index] = Cell.new(coordinates, new_state)
      end
    end
  end

  def neighbors_for(coordinates)
    [:left, :right, :top, :bottom, :top_left, :top_right, :bottom_left, :bottom_right].collect do |direction|
      lookup(coordinates.send(direction))
    end.compact
  end

  def lookup(coordinates)
    cells[coordinates.x][coordinates.y]
  end

  def each
    @cells.each do |row|
      row.each do |cell|
        yield cell
      end
    end
  end

  def still_has_life?
    self.any?{|cell| cell.alive? }
  end

  def to_s
    output = ''
    @cells.each do |row|
      row.each do |cell|
        output << (cell.alive? ? '☻' : ' ')
      end
      output << "\n"
    end
    output
  end

  private

  def cells
    @cells
  end
end
