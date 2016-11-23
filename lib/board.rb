class Board
  @@players = [:x, :o]
  
  attr_reader :state
  
  def initialize(state)
    @state = state
    @move_count = 0
  end
  
  # Answers an array of the columns which are not full
  def possible_moves
    possibles = []
    @state.each_with_index do |column, i|
      possibles << i if column[5] == :e
    end
    possibles
  end
  
  # Move is a 0-indexed column
  def play_move(move)
    found_cell = false
    @state[move].map! do |cell|
      if (!found_cell && cell == :e)
        found_cell = true
        next_mover
      else
        cell
      end
    end
    
    @move_count += 1
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
    
    # There's a diagonal if you start from a 4 column x 3 row block 
    # in the bottom left and go up and right
    # OR
    # you start from a 4 column x 3 row block in the bottom right and
    # go up and left
    4.times do |col|
      3.times do |row|
        if (@state[col][row] != :e)
          return true if (@state[col][row] == @state[col+1][row+1] && @state[col+1][row+1] == @state[col+2][row+2] && @state[col+2][row+2] == @state[col+3][row+3])
        end
      end
    end
    (3..6).each do |col|
      3.times do |row|
        if (@state[col][row] != :e)
          return true if (@state[col][row] == @state[col-1][row+1] && @state[col-1][row+1] == @state[col-2][row+2] && @state[col-2][row+2] == @state[col-3][row+3])
        end
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
  
  def board_view
    lines = []
    6.times do |row|
      line = []
      7.times do |column|
        cell_contents = @state[column][row]
        if (cell_contents == :e)
          line << "_"
        else
          line << cell_contents.to_s.upcase
        end
      end
      lines << line.join("|")
    end
    lines.reverse  
  end
  
  def board_status
    status = []
    status << "1 2 3 4 5 6 7"
    status << "Choose from columns 1-7 to connect four!"
    status << "Next player to move is " + next_mover.to_s.upcase
    status.join("\n")
  end
    
  private
  def next_mover
    @@players[@move_count % 2]
  end
  
  
end