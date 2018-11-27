module MatrixHelper

  def MatrixHelper.add(first_2d_matrix, second_2d_matrix)
    #
    # Add two nxm matricies (of depth 2) together by summing each cell together
    #
    # Given:
    #   [ [ 1 , nil , 3 , 4 ] ]  ,  [ [ 1 , 1 , nil, 5 ] ]
    #
    # Yields:
    #   [ [ 2 , 1 , 3 , 9 ] ]
    #
    first_2d_matrix.each_with_index.map do |row, row_idx|
      row.each_with_index.map do |el, col_idx|
        el.nil? ? second_2d_matrix[row_idx][col_idx] : ((el + second_2d_matrix[row_idx][col_idx]) rescue el)
      end
    end
  end

  def MatrixHelper.occupied_spaces(two_dimensional_matrix)
    #
    # Return coords of spaces that are occupied (non-nil)
    #
    # Given:
    #   [ [ :x  , nil , :x  ],
    #     [ nil , :x  , :x  ],
    #     [ :x  , nil , nil ] ]
    #
    # Yields:
    #   [[0, 0], [0, 2], [1, 1], [1, 2], [2, 0]]
    #
    #
    occupied_coords = []

    two_dimensional_matrix.each_with_index do |row, idx_y|
      row.each_with_index do |x, idx_x|
        (occupied_coords << [idx_y, idx_x]) unless two_dimensional_matrix[idx_y][idx_x].nil?
      end
    end

    occupied_coords
  end

  def MatrixHelper.remove_overlap(matrix, list_of_matricies)
    #
    # Given a 2D matrix  and a list containing a list of matrix positions for each type of piece,
    # remove all matricies that intersect with the `matrix`
    #
    # Given:
    #   [[1, nil] , [nil , nil]]
    #
    # And:
    #   [ 
    #     [[1   ,1  ] , [1, 1  ]] ,
    #     [[nil ,1  ] , [1, 1  ]] ,
    #     [[1   ,nil] , [1, nil]]
    #   ]
    #
    # Yields:
    #   [
    #     [[nil , 1], [1, 1]]
    #   ]
    #
    current_occupied_spaces   = MatrixHelper.occupied_spaces(matrix.layout)
    #current_occupied_spaces   = MatrixHelper.occupied_spaces(matrix)
    non_conflicting_matricies = []

    list_of_matricies.each_with_index do |matricies_for_piece, idx|
      non_conflicting_matricies << []

      matricies_for_piece.each do |matrix_for_piece|
        new_occupied_spaces = MatrixHelper.occupied_spaces(matrix_for_piece.layout)

        if (new_occupied_spaces & current_occupied_spaces).length.zero?
          non_conflicting_matricies[idx] << matrix_for_piece
        end
      end
    end

    non_conflicting_matricies
  end

end
