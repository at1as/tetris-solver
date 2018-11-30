require_relative '../solver'
require_relative '../matrix_helper'

RSpec.describe Solver do

  it "should find a trivial solution" do 
    x = 4
    y = 1
    piece_map = {
      tetromino_i: 1
    }

    s = Solver.new(x, y, piece_map)
    output_board = s.run.layout

    expect(output_board).to eq([["i", "i", "i", "i"]])
  end

  it "should find simple solution" do
    x = 5
    y = 4
    piece_map = {
      tetromino_o: 2,
      tetromino_i: 3
    }

    s = Solver.new(x, y, piece_map)
    output_board = s.run

    expect(output_board.layout).not_to be_nil 
    expect(output_board.layout.flatten.select {|x| x == "o"}.count).to eq(8)
    expect(output_board.layout.flatten.select {|x| x == "i"}.count).to eq(12)
    
    # TODO: There are multiple valid solutions, such as the below
    #       Need to test the validity of the piece shape beyond just the character count
    #  [
    #    ["o", "o", "i", "i", "i"],
    #    ["o", "o", "i", "i", "i"],
    #    ["o", "o", "i", "i", "i"],
    #    ["o", "o", "i", "i", "i"]
    #  ]
  end

  it "should not find solution to ill-posed problem" do
    x = 2
    y = 4
    piece_map = { tetromino_o: 1 , tetromino_i: 1 }

    s = Solver.new(x, y, piece_map)
    output_board = s.run

    expect(output_board).to eq(nil)
  end

  it "should find a moderately complex solution (4x10)" do
    x = 4
    y = 10
    piece_map = {
      tetromino_i: 2,
      tetromino_o: 2,
      tetromino_t: 2,
      tetromino_j: 0,
      tetromino_l: 2,
      tetromino_s: 1,
      tetromino_z: 1,
    }
    
    s = Solver.new(x, y, piece_map)
    output_board = s.run

    
  end

  it "should find a quite complex solution (5x10)" do
    x = 5
    y = 8
    piece_map = {
      tetromino_i: 2,
      tetromino_o: 2,
      tetromino_t: 2,
      tetromino_j: 1,
      tetromino_l: 1,
      tetromino_s: 1,
      tetromino_z: 1
    }
    
    s = Solver.new(x, y, piece_map)
    output_board = s.run
    puts "XYZ"

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
