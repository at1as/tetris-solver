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

  # TODO: i s j l t o
  it "should return a tetronimo_z" do
    t_z = Pieces.tetromino_z

    expect(t_z.color).to eq(:yellow)
    expect(t_z.name).to eq(:tetromino_z)
    expect(t_z.character).to eq("z")
    expect(t_z.shape).to eq([
      ["z", "z", nil],
      [nil, "z", "z"]
    ])
  end

  it "should color in board with nil values" do
    board = [
      ["z", "z", "z", "s", "l", "i", nil],
      [nil, nil, nil, nil, nil, nil, nil]
    ]

    expect(Pieces.color_all(board)).to eq([
      ["\e[0;33;49mz\e[0m", "\e[0;33;49mz\e[0m", "\e[0;33;49mz\e[0m", "\e[0;92;49ms\e[0m", "\e[0;32;49ml\e[0m", "\e[0;31;49mi\e[0m", nil],
      [nil, nil, nil, nil, nil, nil, nil]
    ])
  end

  it "should return non-square dimensions" do
    board = [
      %w( x x x x x x ),
      %w( x x x x x x ),
      %w( x x x x x x )
    ]

    expect(Pieces.dimensions(board)).to eq({ x: 6, y: 3 })
  end

  it "should return square dimensions" do
    board = [
      %w( x x x x x x ),
      %w( x x x x x x ),
      %w( x x x x x x ),
      %w( x x x x x x ),
      %w( x x x x x x ),
      %w( x x x x x x )
    ]

    expect(Pieces.dimensions(board)).to eq({ x: 6, y: 6 })
  end

  it "should return empty board dimensions" do
    board = [
      []
    ]

    expect(Pieces.dimensions(board)).to eq({ x: 0, y: 1 })
  end

  it "should return single row board dimensions" do
    board = [
      %w(x x x x)
    ]

    expect(Pieces.dimensions(board)).to eq({ x: 4, y: 1 })
  end

  it "should swap characters with nil" do
    board = [
      [ "." , "X" , "." ],
      [ "X" , "X" , "X" ]
    ]
    
    target  = "."
    new_val = nil

    expect(Pieces.swap(board, target, new_val)).to eq([
      [ nil , "X" , nil ],
      [ "X" , "X" , "X" ]
    ])
  end

  it "should swap nil with characters" do
    board = [
      [ nil , "A" , nil ],
      [ "" ,  :c , "dd" ]
    ]
    
    target  = nil 
    new_val = "."

    expect(Pieces.swap(board, target, new_val)).to eq([
      [ "." , "A" , "." ],
      [ "" , :c , "dd" ]
    ])
  end
end
