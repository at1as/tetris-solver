require_relative '../solver'

RSpec.describe Solver do

  it "should solve puzzle 'World Hub A: Tutorial'" do 
    x = 4
    y = 3
    piece_map = {
      tetromino_l: 2,
      tetromino_s: 1
    }

    s = Solver.new(x, y, piece_map)
    output_board = s.run.layout

    expect(output_board).to_not be_nil
  end

  it "should solve puzzle 'World Hub A: Gate A'" do 
    x = 4
    y = 4
    piece_map = {
      tetromino_i: 1,
      tetromino_l: 1,
      tetromino_j: 1,
      tetromino_z: 1
    }

    s = Solver.new(x, y, piece_map)
    output_board = s.run.layout

    expect(output_board).to_not be_nil
  end

  it "should solve puzzle 'World Hub A: Star Gate A'" do 
    x = 5
    y = 8
    piece_map = {
      tetromino_s: 2,
      tetromino_z: 2,
      tetromino_j: 1,
      tetromino_l: 1,
      tetromino_t: 4
    }

    s = Solver.new(x, y, piece_map)
    output_board = s.run.layout

    expect(output_board).to_not be_nil
  end

end
