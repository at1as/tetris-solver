class Board
  attr_reader :x, :y, :layout

  def initialize(x, y)
    @x = x 
    @y = y
    @layout = Array.new(@y) { Array.new(@x, nil) }
  end

  def size
    [ @x, @y ]
  end

  def place(x, y, val = "X")
    @layout[x][y] = val
  end

  def merge_boards(other_board)
    other_board.layout.each_with_index do |row, row_idx|
      row.each_with_index do |val, col_idx|
        place(row_idx, col_idx, val) unless val.nil?
      end
    end
  end
end
