class Board
  @@players = [:x, :o]
  
  attr_reader :state
  
  def initialize(state)
    @state = state
    @move_count = 0
  end
  
  # Answers an array of the columns which are not full
  def possible_moves
    [0, 1, 2, 3, 4, 5, 6]
  end
  
  # Move is a 0-indexed column
  def play_move(move)
    col = @state[move]
    puts "col is #{col}"
    found_cell = false
    col2 = col.map do |cell|
      #puts "move is #{move}, cell is #{cell}, i is #{i}"
      if (!found_cell && cell == :e)
        #puts "about to modify #{@state[move][i]}"
        found_cell = true
        next_mover
      else
    
        puts "****"
        view = board_view
        view.each do |l|
          puts l
        end
        puts "@@@@@@@@@@@@@"
        
        cell
      end
    end
    
    @state[move] = col2
    
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
          line << " "
        else
          line << cell_contents.to_s.upcase
        end
      end
      lines << line.join(" ")
    end
    lines.reverse  
  end
  
  def board_status
    "Next player to move is " + next_mover.to_s.upcase
  end
    
  private
  def next_mover
    @@players[@move_count % 2]
  end
  
  
end