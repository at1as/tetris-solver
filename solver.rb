require_relative 'board'
require_relative 'matrix_helper'
require_relative 'pieces'
require_relative 'printer'

class Solver

  attr_accessor :pieces

  def initialize(x, y, piece_map)
    @x = x
    @y = y
    @piece_map = piece_map
    @pieces    = []

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

    boards.
      reject(&:nil?).
      select { |b| MatrixHelper.is_solveable_matrix(b.layout) }
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

  $solution = nil
  $iter = 0

  def solver_r(current_board, list_of_positions_per_piece, iterations = 0)
    $iter = $iter + 1
    puts "#{iterations} -> #{$iter}"
    return if $solution
    
    valid_piece_placements = find_non_colliding_solutions(current_board, list_of_positions_per_piece)

    valid_piece_placements.each_with_index do |piece_placement,idx|
      return if $solution
      piece_placement.lazy.each do |possible_solution|
        return if $solution
        next_board = Marshal.load(Marshal.dump(current_board))
        #next_board = current_board.clone
        next_board.merge_boards(possible_solution)

        if next_board.filled?
          $solution = next_board
          break
        else
          solver_r(next_board, valid_piece_placements[idx+1..-1], iterations + 1)
        end
      end
    end
  end

  def run
    board = Board.new(@x, @y)
    piece_position_map = all_pieces_all_possible_locations

    result = solver_r(board, piece_position_map, 0)

    Printer.solution($solution, board, @piece_map)
  end
end
