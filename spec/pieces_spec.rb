require_relative '../pieces'

RSpec.describe Pieces do

  it "should rotate 'L' piece and retain nils" do
    piece = [
      ["l", nil, nil],
      ["l", "l", "l"]
    ]

    expect(Pieces.rotations(piece)).to eq(
      [
        [
          ["l", nil, nil],
          ["l", "l", "l"]
        ],
        [
          ["l", "l"],
          ["l", nil],
          ["l", nil]
        ],
        [
          ["l", "l", "l"],
          [nil, nil, "l"],
        ],
        [
          [nil, "l"],
          [nil, "l"],
          ["l", "l"]
        ]
      ]
    )

  end

  it "should rotate 'I' piece and remove duplicates" do
    piece = [
      ["I", "I", "I", "I"]
    ]

    expect(Pieces.rotations(piece)).to eq(
      [
        [
          ["I", "I", "I", "I"]
        ],
        [
          ["I"],
          ["I"],
          ["I"],
          ["I"]
        ]
      ]
    )

  end

  it "should rotate 'O' piece and remove duplicates" do
    piece = [
      ["O", "O"],
      ["O", "O"]
    ]

    expect(Pieces.rotations(piece)).to eq(
      [
        [
          ["O", "O"],
          ["O", "O"]
        ],
      ]
    )
  end

end
