require_relative 'board'
require_relative 'matrix_helper'
require_relative 'pieces'
require 'byebug'

class Solver

  attr_accessor :pieces

  def initialize
    #@x = 5
    #@y = 8
    #@piece_map = {
    #  tetromino_i: 2,
    #  tetromino_o: 2,
    #  tetromino_t: 2,
    #  tetromino_j: 1,
    #  tetromino_l: 1,
    #  tetromino_s: 1,
    #  tetromino_z: 1,
    #}
    @x = 5
    @y = 4
    @piece_map = { tetromino_o: 2 , tetromino_i: 3 }
    @pieces = []

    populate_piece_buffer
  end

  def populate_piece_buffer
    @piece_map.each do |piece_type, quantity|
      quantity.times { @pieces << Pieces.send(piece_type) }
    end
  end

  def place_on_board(piece, x_offset, y_offset)
    board = Board.new(@x, @y)

    piece.each_with_index do |row, idx_y|
      row.each_with_index do |x, idx_x|
        board.place(
          idx_x + x_offset,
          idx_y + y_offset,
          piece[idx_y][idx_x]
        )
      end
    end

    board
  rescue
    nil
  end

  
  def all_possible_places_on_board(piece)
    orientations = Pieces.rotations(piece.shape)
    boards = []

    orientations.each do |p|
      piece_height = Pieces.dimensions(p)[:x]
      piece_width  = Pieces.dimensions(p)[:y]

      (0..(@y - (piece_height))).each do |idx_y|
        (0..(@x - (piece_width))).each do |idx_x|
          boards << place_on_board(p, idx_y, idx_x)
        end
      end
    end

    boards.reject(&:nil?)
  end

  def all_pieces_all_possible_locations
    placed_pieces = @pieces.clone.shuffle
    possible_positions_per_piece = [] 

    while (next_piece = placed_pieces.pop)
      possible_positions_per_piece << all_possible_places_on_board(next_piece)
    end

    possible_positions_per_piece
  end

  def find_non_colliding_solutions(initial_frame, possible_matricies_per_piece)
    valid_matricies_per_piece = MatrixHelper.remove_overlap(initial_frame, possible_matricies_per_piece)
  end



  def solver2
    piece_position_map = all_pieces_all_possible_locations
    initial_frame      = piece_position_map.shift

    initial_frame.each do |frame|
      valid_additions = check_solution(frame, piece_position_map)
    
      MatrixHelper.add

    end
  end

  def solver_r(current_board, list_of_matricies, iterations = 0)
    puts iterations
    
    while !list_of_matricies.length.zero?
      list_of_non_colliding_matricies = find_non_colliding_solutions(current_board, list_of_matricies)

      next if list_of_non_colliding_matricies.any? { |piece_placements| piece_placements.empty? }
      
      next_piece_placements = list_of_non_colliding_matricies.first
      next_piece_placements.each do |matrix|

        # check if list_on_non_colliding_matricis is of length one
        # check if current_board.imerge_board(matrix) has no conflicts
        # if so, return
        #next_board = current_board.merge_boards(matrix)
        next_board = current_board.clone
        next_board.merge_boards(matrix)


        if list_of_non_colliding_matricies.length == 1
          puts "SOLUTION@"
          return next_board          
        end

        #next_board = current_board.merge_board(matrix)
        return solver_r(next_board, list_of_non_colliding_matricies[1..-1], iterations + 1)
      end
    end
  end

  def solver_run
    board = Board.new(@x, @y)
    piece_position_map = all_pieces_all_possible_locations

    result = solver_r(board, piece_position_map, 0)

    if result.nil?
      puts "No valid solutions"
    else
      puts "Solution found!\n"

      result.layout.each do |row|
        puts "#{row}"
      end
        
      result
    end
  end
end
