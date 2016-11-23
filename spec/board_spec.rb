require './lib/board'

describe Board do

  let(:empty_column) do
    column = []
    6.times { column << :e }
    column
  end
  
  let(:empty_state) do
    state = []
    7.times { state << empty_column }
    state
  end
    
  describe "#done?" do
    it "all empty not done" do
      expect(Board.new(empty_state).done?).to be false
    end
  
    it "4 in a row done" do
      state = []
      3.times { state << empty_column }
      4.times { state << [:x, :e, :e, :e, :e, :e]}
      expect(Board.new(state).done?).to be true
    end  
    
    it "when full done" do
      state = []
      2.times { state << [:o, :o, :o, :x, :o, :o] }
      2.times { state << [:x, :x, :x, :o, :x, :x] }
      2.times { state << [:o, :o, :o, :x, :o, :o] }
                state << [:x, :x, :x, :o, :x, :x]
      expect(Board.new(state).done?).to be true
    end
  end
  
  describe "#board_view" do
    it "answers the lines to output to the screen" do
      state = []
      3.times { state << empty_column }
      4.times { state << [:x, :e, :e, :e, :e, :e]}
      board = Board.new(state)
      lines = board.board_view
      
      expected = []
      expected << "             "
      expected << "             "
      expected << "             "
      expected << "             "
      expected << "             "
      expected << "      X X X X"
      
      expect(lines).to eql(expected)
    end
  end
  
  describe "#play_move" do
    it "puts pieces in the right place" do
      
 
      
      board = Board.new(empty_state)


      view = board.board_view
      view.each do |l|
        puts l
      end



      board.play_move(4)
      board.play_move(4)
      board.play_move(2)
      board.play_move(4)

      view = board.board_view
      view.each do |l|
        puts l
      end



      
      expected_state = []
      2.times { expected_state << empty_column }
      expected_state << [:x, :e, :e, :e, :e, :e]
      expected_state << empty_column
      expected_state << [:x, :o, :o, :e, :e, :e]
      2.times { expected_state << empty_column }
      
      expect(board.state).to eql(expected_state)
    end
  end
  
  describe "#possible_moves" do
    it "knows which columns aren't full" do
      state = []
      
      # columns 0, 1, 4 and 6 aren't full
      2.times { state << empty_column }
      2.times { state << [:o, :o, :o, :x, :o, :o] }
      state << empty_column 
      state << [:x, :x, :x, :o, :x, :x]
      state << empty_column 
      
      
      expect(Board.new(state).possible_moves).to eql([0, 1, 4, 6])
    end
  end
  
end
      