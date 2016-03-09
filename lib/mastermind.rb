require_relative "./mastermind/version"

module Mastermind
  class Game

  end

  class DecodeBoard
    attr_accessor :board
    def initialize(input = {})
      @board = input.fetch(:board, default_board)
    end

    def formatted_board
      board.each do |row|
        print "#{row.row_id + 1} |"
        row.data.each { |slot| print "#{slot.value}" + "|" }
        puts ""
      end
    end

    def row_to_array(row)
      @row_array = []
      row.data.each { |e| @row_array << e.value  }
      @row_array
    end

    def ask_guess
      puts "Please enter your guess:"
      gets.chomp
    end

    def set_row
      p ask_guess.split(//)
    end

    private

    def default_board
      Array.new(12) { Row.new }
    end
  end

  class ColorCode
    attr_accessor :code
    def initialize(code = [])
      @code = code
    end

    def set_code
      @code = Array.new(4)
      return @code.map! { |e| e = rand(1..6) }
    end
  end

  class Row
    attr_accessor :data, :row_id
    @@row_count = 0
    def initialize(data = Array.new(4) { Slot.new } )
      @data = data
      @row_id = @@row_count
      @@row_count += 1
    end

    def row_count
      @@row_count
    end
  end

  class Slot
    attr_accessor :value
    def initialize(value = "O")
      @value = value
    end
  end

  class Player
    attr_accessor :name, :points
    def initialize(name)
      @name = name
    end
  end
end

include Mastermind

a = DecodeBoard.new
a.set_row
# a.formatted_board
# b = ColorCode.new
# p b.set_code
# p b.code
