require_relative '../solver'
require_relative '../matrix_helper'

RSpec.describe Solver do
  it "should work" do
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
    
    s = Solver.new
    boards  = s.all_possible_places_on_board(Pieces.tetromino_i)
    expect(boards.length).to eq(41)

    boards_in_all_orientations = s.all_pieces_all_possible_locations
    expect(boards_in_all_orientations.length).to eq(10)
    expect(boards_in_all_orientations.flatten.length).to eq(588) #678) VERIFY ME!!!

    initial_board    = boards_in_all_orientations.first.first
    all_other_boards = boards_in_all_orientations[1..boards_in_all_orientations.length]
    expect(all_other_boards.length).to eq(9)
    expect(all_other_boards.flatten.length).to eq(547) # VERIFY ME!!!

    #valid_rest_of_em = MatrixHelper.remove_overlap(chosen_one, rest_of_em)
    valid_rest_of_em = MatrixHelper.remove_overlap(chosen_one, rest_of_em)
    expect(b1.layout).to eq([ [ "b2-(0,0)" , nil ] , [ nil, "b1-(1,1)" ] ])

  end
end
