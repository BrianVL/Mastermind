require_relative "./mastermind/version"

module Mastermind
  class Game

  end

  class DecodeBoard
    attr_accessor :board
    def initialize(input = {})
      @board = input.fetch(:board, default_board)
    end

    def default_board
      Array.new(12) { Array.new(4) { Slot.new } }
    end

    def formatted_board
      board.each do |row|
        print "|"
        row.each { |slot| print "#{slot.value}" + "|" }
        puts ""
      end
    end
  end

  class ColorCode

  end

  class RowGrid

  end

  class Slot
    attr_accessor :value
    def initialize(value = "O")
      @value = value
    end
  end

  class Player

  end
end

a = Mastermind::DecodeBoard.new
a.formatted_board
