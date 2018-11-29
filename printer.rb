require 'colorize'

module Printer 

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
        solution.layout.each { |r| puts r.to_s }
    end
  end

  def Printer.solution(solution, board, pieces, return_solution = true)
    Printer.header(board, pieces)
    Printer.info(solution)

    solution if return_solution
  end

end
