require './lib/game'

describe Game do
  
  describe "#get_move" do
    it "allows user to choose column" do
      expect(STDIN).to receive(:getch).and_return("6")
      expect(Game.new.get_move([0, 1, 2, 3, 4, 5, 6])).to eql(5)
    end
    
    it "requires keep choosing characters until you pick a valid one" do
      expect(STDIN).to receive(:getch).and_return("9", "8", "7")
      expect(Game.new.get_move([0, 1, 2, 3, 4, 5, 6])).to eq(6)
    end
    
    it "only accepts possible moves" do
      expect(STDIN).to receive(:getch).and_return("3", "2", "1")
      expect(Game.new.get_move([0, 6])).to eql(0)
    end      
  end
  
  
end