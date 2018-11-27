require 'colorize'

# See : https://en.wikipedia.org/wiki/Tetromino
module Pieces

  def Pieces.container
    Struct.new(
      :color,
      :name,
      :shape,
      :character
    )
  end

  def Pieces.swap(shape, target, value)
    #
    # Replace all array elements of value `target` with `value`
    #
    # Given:
    #   [[ "." , "X" , "." ],
    #    [ "X" , "X" , "X" ]] , "." , nil
    #
    # Return
    #   [[ nil , "X" , nil ],
    #    [ "X" , "X" , "X" ]]
    #
    shape.each_with_index.map do |row, row_num|
      row.each_with_index.map do |el, col_num|
        el == target ? value : shape[row_num][col_num]
      end
    end
  end

  def Pieces.rotations(piece)
    #
    # Given a 2 dimensional matrix, returns original matrix along with rotations by 90, 180, and 270 degrees
    # Will return only unique entries (a square returns only one element, while tetromino_t - shown below - returns four elements)
    #
    # Given:
    #   [ [ nil , "X" , nil ] ,
    #     [ "X" , "X" , "X" ] ]
    #
    # Return:
    #   [
    #     [[ nil , "X" , nil ],
    #      [ "X" , "X" , "X" ]],
    #
    #     [[nil, "X"],
    #      ["X", "X"],
    #      [nil, "X"]],
    #
    #     [[ "X" , "X" , "X" ],
    #      [ nil , "X" , nil ]],
    #
    #     [["X", nil],
    #      ["X", "X"],
    #      ["X", nil]]
    #   ]

    clockwise_90  = piece.reverse.transpose
    clockwise_180 = clockwise_90.reverse.transpose
    clockwise_270 = clockwise_180.reverse.transpose
    
    [
      piece,
      clockwise_90,
      clockwise_180,
      clockwise_270
    ].uniq
  end

  def Pieces.color_in(shape, color)
    #
    # Wrap each array element in terminal color escape characters
    #
    # Given:
    #   [[ nil , "X" ],
    #    [ "X" , "X" ]]
    #
    # Return:
    #   [[      nil           , "\e[0;31;49mX\e[0m" ], 
    #    ["\e[0;31;49mX\e[0m" , "\e[0;31;49mX\e[0m"]]
    #
    shape.map do |row| 
      row.map do |el|
        el.nil? ? el : el.to_s.send(color)
      end
    end
  end

  def Pieces.dimensions(shape)
    #
    # Retun the dimensions of a two-dimensional matrix
    #
    # Given:
    #   [[ 1, 1, 1 ],
    #    [ 1, 1, 1 ]]
    #
    # Return:
    #   {
    #     x: 3,
    #     y: 2
    #   }
    #

    {
      x: shape.first.length,
      y: shape.length
    }
  end


  def Pieces.tetromino_i
    container.new(
      :red,
      __method__,
      [
        %w( i i i i )
      ],
      __method__.to_s.split('_').last
    )
  end
  
  def Pieces.tetromino_o
    container.new(
      :light_red,
      __method__,
      [
        %w( o o ),
        %w( o o )
      ],
      __method__.to_s.split('_').last
    )
  end

  def Pieces.tetromino_t
    container.new(
      :blue,
      __method__,
      Pieces.swap(
        [
          %w( j j j ),
          %w( . j . )
        ],
        ".",
        nil
      ),
      __method__.to_s.split('_').last
    )
  end

  def Pieces.tetromino_j
    container.new(
      :light_blue,
      __method__,
      Pieces.swap(
        [
          %w( j j j ),
          %w( . . j )
        ],
        ".",
        nil
      ),
      __method__.to_s.split('_').last
    )
  end

  def Pieces.tetromino_l
    container.new(
      :green,
      __method__,
      Pieces.swap(
        [
          %w( l l l ),
          %w( l . . )
        ],
        ".",
        nil
      ),
      __method__.to_s.split('_').last
    )
  end

  def Pieces.tetromino_s
    container.new(
      :light_green,
      __method__,
      Pieces.swap(
        [
          %w( . s s ),
          %w( s s . )
        ],
        ".",
        nil
      ),
      __method__.to_s.split('_').last
    )
  end

  def Pieces.tetromino_z
    container.new(
      :yellow,
      __method__,
      Pieces.swap(
        [
          %w( z z . ),
          %w( . z z )
        ],
        ".",
        nil
      ),
      __method__.to_s.split('_').last
    )
  end

end
