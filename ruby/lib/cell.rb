class Cell
  attr_reader :alive
  attr_reader :coordinates

  def self.random_state
    if Random.rand(2) == 0
      :dead
    else
      :alive
    end
  end

  def initialize(coordinates, new_state = :dead)
    @alive = (new_state == :alive)
    @coordinates = coordinates
  end

  def alive?
    !!@alive
  end

  def next_generation_state(neighbors)
    alive_neighbors_count = neighbors.select(&:alive?).length
    case alive_neighbors_count
    when 0, 1 then :dead
    when 2 then alive?
    when 3 then :alive
    else :dead
    end
  end
end
