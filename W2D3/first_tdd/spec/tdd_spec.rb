require 'tdd'

describe Array do
  describe "#my_uniq" do
    subject(:array) { [1, 2, 1, 3, 3] }
    let(:regular_unique) { [7, 7, 7, 7, 1, 2, 1, 3, 3] }
    it "should remove all dupliates from the array" do
      expect(array.my_uniq).to eq([1, 2, 3])
    end

    it "should not modify the original array" do
      array.my_uniq
      expect(array).to eq([1, 2, 1, 3, 3])
    end

    it "returns the unique elements in the same order in which they first appeared" do

      expect(regular_unique.my_uniq).to eq(regular_unique.uniq)
    end

  end

  describe "#two_sum" do
    subject(:array) { [-1, 0, 2, -2, 1] }
    it "finds all pairs of positions where the elements at those positoins sum to zero" do
      expect(array.two_sum).to eq([[0, 4], [2, 3]])
    end

    it "returns an empty array if no two elements sum to zero" do
      expect([].two_sum).to eq([])
    end

    it "sorts dictionary-wise (smaller index before bigger index)" do
      expect(array.two_sum).to eq([[0, 4], [2, 3]])
    end
  end

  describe "#my_transpose" do
    subject(:array) { [
                        [0, 1, 2],
                        [3, 4, 5],
                        [6, 7, 8]
                      ] }
    it "mimics native transpose behavior" do
      expect(array.my_transpose).to eq(array.transpose)
    end

    it "transposes a 2D matrix, hard coded"  do
      expect(array.my_transpose).to eq([[0, 3, 6],
                                         [1, 4, 7],
                                         [2, 5, 8]
                                        ])
    end
  end
end

describe "#stock_picker" do
  subject(:stocks) {[10, 5, 8, 14, 20, 5, 4]}

  it "gives me the profitable buy and sell dates" do
    expect(stock_picker(stocks)).to eq([1, 4])
  end

  it "doesn't tell me to sell stock before I buy it" do
    test_stock = [25, 10, 5, 8, 14, 20, 5, 4]
    expect(stock_picker(stocks).first).to_not eq(0)
  end

  it "works with random arrays" do
    test_stock = (0..99).to_a.shuffle
    expect(stock_picker(test_stock)[0]).to be < (stock_picker(test_stock)[1])
  end

end

describe TowersOfHanoi do
  subject(:tower) { TowersOfHanoi.new }
  describe "#move" do

    it "moves a disc from the specifed tower" do
      tower.move(0, 1)
      expect(tower.towers[0].size).to eq 2
      expect(tower.towers[2]).to be_empty
    end

    it "moves a disc to the specified tower" do
      tower.move(0, 1)
      expect(tower.towers[1].size).to eq 1
      expect(tower.towers[2]).to be_empty
    end

    it "doesn't move a disc onto a bigger disc" do
      tower.move(0, 1)
      puts tower.towers[0]
      expect { tower.move(0, 1) }.to raise_error("invalid move choice")
    end

    it "doesn't move from an empty pile" do
      expect{ tower.move(2, 1) }.to raise_error("invalid move choice")
    end
  end



  describe "#won?" do
    winned_tower = [
                        [],
                        [2, 1, 0],
                        []
                      ]
    let(:won_tower) { TowersOfHanoi.new(winned_tower) }
    it "returns true when tower 0 is empty and tower 1 or 2 is empty" do
      expect(won_tower).to be_won
    end

  end

  describe '#valid_move?' do

    it 'should be called by #move' do
      expect(tower).to receive(:valid_move?)
      tower.move(0, 1)
    end

    it 'should return true if a move is valid' do
      expect(tower.valid_move?(0, 1)).to be true
    end

    it 'should raise error if a move is not valid' do
      tower.move(0, 1)
      expect { tower.valid_move?(0, 1) }.to raise_error('invalid move choice')
    end

  end
end
