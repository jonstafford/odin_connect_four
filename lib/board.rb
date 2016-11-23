class Board
  def initialize(state)
    @state = state
  end
  
  # Answers an array of the columns which are not full
  def possible_moves
    [0, 1, 2, 3, 4, 5, 6]
  end
  
  # Move is a 0-indexed column
  def play_move(move)
  end
  
  def done?
    return true if possible_moves.empty?
    
    @state.each do |column|
      # There are only 3 ways a column can be winning
      if (column[2] != :e)        
        return true if (column[0] == column[1] && column[1] == column[2] && column[2] == column[3])
        return true if (column[4] == column[1] && column[1] == column[2] && column[2] == column[3])
        return true if (column[4] == column[5] && column[5] == column[2] && column[2] == column[3])
      end
    end
    
    # Check each row for win
    6.times do |row|
      # There are 4 ways a row can be winning
      if (@state[3][row] != :e)
        return true if (@state[0][row] == @state[1][row] && @state[1][row] == @state[2][row] && @state[2][row] == @state[3][row])
        return true if (@state[4][row] == @state[1][row] && @state[1][row] == @state[2][row] && @state[2][row] == @state[3][row])
        return true if (@state[4][row] == @state[5][row] && @state[5][row] == @state[2][row] && @state[2][row] == @state[3][row])
        return true if (@state[4][row] == @state[5][row] && @state[5][row] == @state[6][row] && @state[6][row] == @state[3][row])
      end
    end
    
    # Not done if there's still at least one empty cell
    @state.each do |column|
      column.each do |cell|
        return false if :e == cell
      end
    end
    
    # No empty cells left, so done
    return true
  end
  
end