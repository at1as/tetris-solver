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
    # Given a 2D matrix and a list containing a list of matrix positions for each type of piece,
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
    non_conflicting_matricies = []

    list_of_matricies.each_with_index do |matricies_for_piece, idx|
      non_conflicting_matricies << []

      matricies_for_piece.each do |matrix_for_piece|
        new_occupied_spaces = MatrixHelper.occupied_spaces(matrix_for_piece.layout)

        if (new_occupied_spaces & current_occupied_spaces).length.zero?
          (non_conflicting_matricies[idx] << matrix_for_piece) if MatrixHelper.is_solveable_matrix(matrix_for_piece.layout)
          #non_conflicting_matricies[idx] << matrix_for_piece
        end
      end
    end

    non_conflicting_matricies
  end

  def MatrixHelper.neighbors(matrix, r_idx, c_idx)
    #
    # Given a Matrix
    #   [
    #     [ A  B  C ]
    #     [ H  X  D ]
    #     [ G  F  E ]
    #   ]   
    #
    # And coordinates (r_idx, c_idx)
    #
    # Return a list of the neighbors for the piece at (r_idx, c_idx)
    #
    # Ex. Given (1, 1) for the above matrix, will return [B, F, H, D]
    #
    # This method assumes that matrix has rows of equal size (due to `max_cols` below)
    # It also assumes that at least one row is contained (see `upper_neighbor` constraints)
    #

    max_rows = matrix.length
    max_cols = matrix[0].length

    upper_neighbor =  if r_idx == 0
                        :out_of_bounds
                      else
                        matrix[r_idx - 1][c_idx]
                      end

    lower_neighbor =  if r_idx == (max_rows - 1)
                        :out_of_bounds
                      else
                        matrix[r_idx + 1][c_idx]
                      end

    left_neighbor =   if c_idx == 0
                        :out_of_bounds
                      else
                        matrix[r_idx][c_idx - 1]
                      end

    right_neighbor =  if c_idx == (max_cols - 1)
                        :out_of_bounds
                      else
                        matrix[r_idx][c_idx + 1]
                      end
    
    [upper_neighbor, lower_neighbor, left_neighbor, right_neighbor]
  end

  def MatrixHelper.is_solveable_matrix(matrix)
    #
    # Given a 2D Matrix, determine if can be solved given any pieces
    # Cases in which it would not be solveable are where isolated islands of 3 or less pieces form
    # All pieces are 4 characters large, so nothing would be able to fill the void
    #
    # TODO:
    #   This solves the simple case (a piece that is fully encased)
    #   The next step is to look for at minimum 4 connected pieces
    #   And then after that, to do the search knowing which pieces are actually available
    #
    matrix.each_with_index do |row, r_idx|
      row.each_with_index do |col, c_idx|
        next unless matrix[r_idx][c_idx].nil?

        neighbors = MatrixHelper.neighbors(matrix, r_idx, c_idx)
        empty_neighbors = neighbors.select(&:nil?).length

        next         if empty_neighbors > 1
        return false if empty_neighbors == 0
      end
    end

    true
  end

end
