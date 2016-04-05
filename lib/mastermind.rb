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
      row.data.each { |e| @row_array << e.value.to_i  }
      @row_array
    end

    def ask_guess
      puts "Please enter your guess:"
      gets.chomp
    end

    def set_row(row_nr)
      data = ask_guess.split(//)
      @board[row_nr].data.each_with_index  { |item, index| item.value = data[index].to_i }
    end

    def check_code(code, current_row)
      if correct?(code, current_row)
        return :correct
      else
        return :wrong
      end
    end

    def check_keys(code, current_row)
      check_positions(code, current_row)
      check_colors(code, current_row)
    end

    private

    def default_board
      Array.new(12) { Row.new }
    end

    # check if the entered row equals the code. input example to compare 5th row with code_example: (code_example.code, 5)
    def correct?(code, current_row)
      return true if code == row_to_array(@board[current_row])
    end

    def check_positions(code, current_row)
      whites = 0
      @board[current_row].data.each_with_index do |item, index|
        whites += 1 if code[index] == item.value
      end
      puts "whites: #{whites}"
    end

    def check_colors(code, current_row)
      reds = 0
      @board[current_row].data.each_with_index do |item, index|
        if code.include?(item.value) && code[index] != item.value
          reds += 1
          puts "#{index} / #{code[index]} / #{item.value}"
        end
      end
      puts "reds: #{reds}"
    end
  end

  class ColorCode
    attr_accessor :code
    def initialize(code = [])
      @code = code
    end

    def set_code
      @code = Array.new(4)
      @code.map! { |e| e = rand(1..6) }
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

    def self.row_count
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

# a = DecodeBoard.new
# a.set_row(4)
# p a.board[0].data
# b = ColorCode.new
# p b.set_code
# p b.code
# a.check_keys(b.code, 4)
