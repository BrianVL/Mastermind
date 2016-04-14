require_relative "./mastermind/version"

module Mastermind
  class Game
    attr_accessor :board, :code

    def initialize(board = DecodeBoard.new, code = ColorCode.new)
      @board = board
      @code = code
    end

    def winner_text(row)
      puts "You guessed the code in #{row + 1} turns!"
    end

    def computer_guess
      code_guess = Array.new(4)
      code_guess.map! { |e| e = rand(1..6) }
    end

    def play_human
      @board.clear_board
      @code.set_code_auto
      row_number = 0
      while row_number <= 11
        @board.set_row(row_number)
        @board.formatted_board
        @board.check_keys(code.code, row_number)
        if @board.check_code(@code.code, row_number) == :correct
          return winner_text(row_number)
        else
          row_number += 1
        end
      end
      puts "You were unable to guess the code! Try again!"
    end

    def play_computer
      @board.clear_board
      @code.set_code_man
      row_number = 0
      while row_number <= 11
        @board.set_row(row_number, computer_guess)
        @board.formatted_board
        @board.check_keys(code.code, row_number)
        if @board.check_code(@code.code, row_number) == :correct
          return winner_text(row_number)
        else
          row_number += 1
        end
      end
      puts "The computer was unable to correctly guess your code."
    end
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

    def set_row(row_nr, *set_code)
      if set_code == []
        set_code = ask_guess.split(//)
      else
        set_code.flatten!
      end
      @board[row_nr].data.each_with_index  { |item, index| item.value = set_code[index].to_i }
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

    def clear_board
      @board.each do |row|
        row.data.each {|slot| slot.value = "O"}
      end
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
      check_array = code.clone
      @board[current_row].data.each_with_index do |item, index|
        puts "index: #{index} / item: #{item.value} / code: #{code[index]}"
        if check_array.include?(item.value) && code[index] != item.value
          reds += 1
          check_array.delete_at(check_array.find_index(item.value))
          p check_array
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

    def ask_code
      puts "Please enter your color code:"
      gets.chomp
    end

    def set_code_man
      humancode = ask_code.split(//)
      @code = humancode.collect { |value| value = value.to_i }
    end

    def set_code_auto
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
# p b.set_code_auto
# p b.code
# a.check_keys(b.code, 4)
