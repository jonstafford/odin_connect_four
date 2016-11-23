require './lib/board'

describe Board do
  
  describe "#done?" do
    let(:empty_column) do
      column = []
      6.times { column << :e }
      column
    end
    
    it "all empty not done" do
      state = []
      7.times { state << empty_column }
      expect(Board.new(state).done?).to be false
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
  
  
end
      