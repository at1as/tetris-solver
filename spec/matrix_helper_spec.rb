require_relative '../matrix_helper'
require_relative '../pieces'
require_relative '../solver'

RSpec.describe MatrixHelper do

  it "should return true for solveable matrix" do
    matrix = [
      [ nil , "X" , "X" ],
      [ nil , "X" , "X" ],
      [ nil , "X" , "X" ],
      [ nil , "X" , "X" ]
    ]
    expect(MatrixHelper.is_solveable_matrix(matrix)).to eq(true)
  end

  it "should return false for unsolveable matrix (corner)" do
    matrix = [
      [ nil , "X" , "X" ],
      [ "X" , "X" , "X" ],
      [ "X" , "X" , "X" ],
      [ "X" , "X" , "X" ]
    ]
    expect(MatrixHelper.is_solveable_matrix(matrix)).to eq(false)
  end

  it "should return false for unsolveable matrix (corner)" do
    matrix = [
      [ "X" , "X" , "X" ],
      [ "X" , "X" , "X" ],
      [ "X" , nil , "X" ],
      [ "X" , "X" , "X" ]
    ]
    expect(MatrixHelper.is_solveable_matrix(matrix)).to eq(false)
  end

  # TODO: THIS MAY BE IN THE WRONG TEST SUITE
  it "should return all matricies for 'i' piece" do
    i_piece = Pieces.tetromino_i
    x = 5
    y = 5
    s = Solver.new(5, 5, {})
    res = s.all_possible_places_on_board(i_piece)
    expect(res.length).to eq(20)
  end

  it "should return all matricies for 'o' piece" do
    o_piece = Pieces.tetromino_o
    x = 5
    y = 5
    s = Solver.new(5, 5, {})
    res = s.all_possible_places_on_board(o_piece)
    expect(res.length).to eq(16)
  end

  it "should return only valid matricies for 't' piece" do
    t_piece = Pieces.tetromino_t
    x = 5
    y = 5
    s = Solver.new(5, 5, {})
    res = s.all_possible_places_on_board(t_piece)
  
    # Without removals, should be 48 (unsymetric piece can be shifted 3 times per row, 4 columns)
    # => 3 per row * 4 cols * 4 orientations = 48
    #
    # However 8 orientations are invalid (two orientations in each corner)
    # => 40 valid orientations
    #
    expect(res.length).to eq(40)
  end

  it "should return only valid matricies for 'j' piece" do
    j_piece = Pieces.tetromino_j
    x = 5
    y = 5
    s = Solver.new(5, 5, {})
    res = s.all_possible_places_on_board(j_piece)
  
    # Without removals, should be 48 (unsymetric piece can be shifted 3 times per row, 4 columns)
    # => 3 per row * 4 cols * 4 orientations = 48
    #
    # However 4 orientations are invalid (each corner has one invalid orientation)
    # => 44 valid orientations
    #
    expect(res.length).to eq(44)
  end

  it "should return only valid matricies for 'l' piece" do
    l_piece = Pieces.tetromino_l
    x = 5
    y = 5
    s = Solver.new(5, 5, {})
    res = s.all_possible_places_on_board(l_piece)
  
    # Without removals, should be 48 (unsymetric piece can be shifted 3 times per row, 4 columns)
    # => 3 per row * 4 cols * 4 orientations = 48
    #
    # However 4 orientations are invalid (each corner has one invalid orientation)
    # => 44 valid orientations
    #
    expect(res.length).to eq(44)
  end

  it "should return only valid matricies for 's' piece" do
    s_piece = Pieces.tetromino_s
    x = 5
    y = 5
    s = Solver.new(5, 5, {})
    res = s.all_possible_places_on_board(s_piece)
  
    # Without removals, should be 24 (unsymetric piece can be shifted 3 times per row, 4 columns)
    # => 3 per row * 4 cols * 2 orientations (symmetric) = 24
    #
    # However 4 orientations are invalid (two orientations in each corner)
    # => 20 valid orientations
    #
    expect(res.length).to eq(20)
  end

  it "should return only valid matricies for 'z' piece" do
    z_piece = Pieces.tetromino_z
    x = 5
    y = 5
    s = Solver.new(5, 5, {})
    res = s.all_possible_places_on_board(z_piece)
  
    # Without removals, should be 24 (unsymetric piece can be shifted 3 times per row, 4 columns)
    # => 3 per row * 4 cols * 2 orientations (symmetric) = 24
    #
    # However 4 orientations are invalid (two orientations in each corner)
    # => 20 valid orientations
    #
    expect(res.length).to eq(20)
  end

end
