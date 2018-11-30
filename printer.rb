require 'colorize'

module Printer 

  def Printer.colorize(str)
    # Remove/pad characters that interfere with the colored escape sequence
    str.
      gsub('"', "").
      gsub( /\A\[/ ,  "\[ ").
      gsub( /\]\Z/ , " \]")
  end

  def Printer.header(board, pieces)
    puts ?\n
    puts "Board Size: #{board.size}"
    puts "Pieces:"
    pieces.each { |name, count| puts "  #{name.to_s}: #{count}" }
    puts ?\n
  end

  def Printer.info(solution)
    case solution
      when nil
        puts "No solution found".yellow
      else
        puts "Solution found!".green
        formatted_solution = Pieces.color_all(solution.layout)
        formatted_solution.each do |row|
          print "["
          row.each { |c| print " #{c} " }
          print "]\n"
        end
    end
  end

  def Printer.solution(solution, board, pieces, return_solution = true)
    Printer.header(board, pieces)
    Printer.info(solution)

    solution if return_solution
  end

end
