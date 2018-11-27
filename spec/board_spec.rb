require_relative '../board'

RSpec.describe Board do
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
