require_relative '../pieces'

RSpec.describe Pieces do

  it "should rotate 'J' piece and retain nils" do
    piece = [
      ["j", nil, nil],
      ["j", "j", "j"]
    ]

    expect(Pieces.rotations(piece)).to eq(
      [
        [
          ["j", nil, nil],
          ["j", "j", "j"]
        ],
        [
          ["j", "j"],
          ["j", nil],
          ["j", nil]
        ],
        [
          ["j", "j", "j"],
          [nil, nil, "j"],
        ],
        [
          [nil, "j"],
          [nil, "j"],
          ["j", "j"]
        ]
      ]
    )
  end

  it "should rotate 'L' piece and retain nils" do
    piece = [
      ["l", "l", "l"],
      ["l", nil, nil]
    ]

    expect(Pieces.rotations(piece)).to eq(
      [
        [
          ["l", "l", "l"],
          ["l", nil, nil]
        ],
        [
          ["l", "l"],
          [nil, "l"],
          [nil, "l"]
        ],
        [
          [nil, nil, "l"],
          ["l", "l", "l"],
        ],
        [
          ["l", nil],
          ["l", nil],
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

  it "should rotate 'S' piece" do
    piece = [
      [nil, "s", "s"],
      ["s", "s", nil]
    ]

    expect(Pieces.rotations(piece)).to eq(
      [
        [
          [nil, "s", "s"],
          ["s", "s", nil]
        ],
        [
          ["s", nil],
          ["s", "s"],
          [nil, "s"]
        ],
      ]
    )
  end

  it "should rotate 'Z' piece" do
    piece = [
      ["s", "s", nil],
      [nil, "s", "s"]
    ]

    expect(Pieces.rotations(piece)).to eq(
      [
        [
          ["s", "s", nil],
          [nil, "s", "s"]
        ],
        [
          [nil, "s"],
          ["s", "s"],
          ["s", nil]
        ],
      ]
    )
  end

  it "should rotate 'T' piece and retain nils" do
    piece = [
      [nil, "t", nil],
      ["t", "t", "t"]
    ]

    expect(Pieces.rotations(piece)).to eq(
      [
        [
          [nil, "t", nil],
          ["t", "t", "t"]
        ],
        [
          ["t", nil],
          ["t", "t"],
          ["t", nil]
        ],
        [
          ["t", "t", "t"],
          [nil, "t", nil],
        ],
        [
          [nil, "t"],
          ["t", "t"],
          [nil, "t"]
        ]
      ]
    )
  end
end
