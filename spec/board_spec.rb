require_relative '../board'

RSpec.describe Board do
  it "should return empty board size (0, 0)" do
    b = Board.new(0, 0)
    expect(b.size).to eq([0, 0])
  end

  it "should return board size (2, 2)" do
    b = Board.new(2, 2)
    expect(b.size).to eq([2, 2])
  end

  it "should return filled? = false for initialized board" do
    b = Board.new(3, 3)
    expect(b.filled?).to eq(false)
  end

  it "should return filled? = true once board is filled" do
    b = Board.new(2, 2)
    b.place(0, 0, "X")
    expect(b.filled?).to eq(false)
    b.place(0, 1, "X")
    expect(b.filled?).to eq(false)
    b.place(1, 0, "X")
    expect(b.filled?).to eq(false)
    b.place(1, 1, "X")
    expect(b.filled?).to eq(true)
  end

  it "should add boards together while retaining existing values" do

    b1 = Board.new(2, 2)
    expect(b1.layout).to eq([ [ nil , nil ] , [ nil , nil ] ])

    b2 = Board.new(2, 2)
    expect(b2.layout).to eq([ [ nil , nil ] , [ nil , nil ] ])

    b1.place(1, 1, "b1-(1,1)")
    expect(b1.layout).to eq([ [ nil , nil ] , [ nil , "b1-(1,1)" ] ])

    b2.place(0, 0, "b2-(0,0)")
    expect(b2.layout).to eq([ [ "b2-(0,0)" , nil ] , [ nil , nil ] ])

    b1.merge_boards(b2)
    expect(b1.layout).to eq([ [ "b2-(0,0)" , nil ] , [ nil, "b1-(1,1)" ] ])
  end
end
