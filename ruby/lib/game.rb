require_relative 'grid.rb'
require_relative 'coordinates'
require_relative 'cell'
require 'pry'

class Game
  def initialize(tick_count = 25)
    @tick_count = tick_count
    @current_board = Grid.new
  end

  def run!
    print "\e[H\e[2J" # clear the screen
    @tick_count.times do |count|
      if count > 0
        print "\r" # move to the beginning of the line
        print "\033[1A" * Grid.size # move up Grid.size lines
      end
      print @current_board.to_s
      sleep 1
      @current_board = Grid.next_state(@current_board)
      unless @current_board.still_has_life?
        puts "All cells are dead after #{count + 1} generations. Terminating early."
        break
      end
    end
  end
end

Game.new.run!
