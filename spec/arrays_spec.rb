require 'array.rb'

describe "Array#my_uniq" do
  let(:array) { [1,2,3] }

  it 'an empty returns an empty array' do
    expect([].my_uniq).to eq([])
  end

  it 'removes duplicates from the array' do
    expect([3,2,1,2,1].my_uniq).to eq([3,2,1])
  end

  it 'does not modify the original array' do
    expect(array.my_uniq.object_id).not_to eq(array.object_id)
  end

end

describe "Array#two_sum" do
  let(:array) { [-1, 0, 2, -2, 1] }

  it 'returns an array containing the indexes' do
    expect(array.two_sum).to eq([[0, 4], [2, 3]])
  end

  it 'does not modify the original array' do
    expect(array.two_sum.object_id).not_to eq(array.object_id)
  end

end


describe "Array#my_transpose" do

  let(:array) { [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]}

  let(:cols) {[
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ]}

  let(:wrong_rows) {[
    [0, 3, 6, 9],
    [1, 4, 7],
    [2, 5, 8]
  ]}

  it 'transposes the rows and columns' do
    expect(array.my_transpose).to eq(cols)
  end

  it 'does not modify the original array' do
    expect(array.my_transpose.object_id).not_to eq(array.object_id)
  end

  it 'raises an error if rows arent the same length' do
    expect { wrong_rows.my_transpose }.to raise_error(IndexError)
  end

end

describe "#stock_picker" do
  let(:stocks) { [10,11,4,7,3,8,13] } #[4,6]

  it "find the most profitable pair of days" do
    expect(stock_picker(stocks)).to eq([4,6])
  end

  it "the sell date is after the buy date" do
    expect(stock_picker(stocks).inject(:-)).to be < 0
  end
end

describe TowersOfHanoi do
  let(:game) { TowersOfHanoi.new }

  describe "#initalize" do

    it "creates a full first tower" do
      expect(game.towers.first).to eq([3,2,1])
    end

    it "has two empty towers" do
      expect(game.towers[1..-1]).to eq([[],[]])
    end

  end

  describe "#towers" do

    it "initializes towers instance variable" do
      ivar = game.instance_variable_get(:@towers)

      expect(game.towers).to eq(ivar)
    end

    it "it initializes @towers as an array" do
      expect(game.towers.class).to be(Array)
    end

    it "contains arrays" do
      expect(game.towers.all? {|tower| tower.is_a?(Array)}).to be(true)
    end

    it "holds only Fixums as discs" do
      game.towers.each do |tower|
        expect(tower.all? { |d| d.is_a? Fixnum }).to be(true)
      end
    end
  end

  describe "#move_disc" do

    before(:each) do
      game.move_disc(0, 2)
    end

    it "pops the disk off a tower" do
      expect(game.towers.first).to eq([3, 2])
    end

    it "pushes the disk onto a tower" do
      expect(game.towers.last).to eq([1])
    end

    it "doesnt effect involved towers" do
      expect(game.towers[1]).to be_empty
    end

    it "expects an error if you move large disc onto a small disk" do
      expect { game.move_disc(0, 2) }.to raise_error(HanoiError)
    end

    it "expects an error if you try to move form an empty tower" do
      expect { game.move_disc(1,3) }.to raise_error(HanoiError)
    end

  end

  describe "#won?" do

    it "returns false when you haven't won" do
      expect(game.won?).to be false
    end

    it "returns true when all the discs are on the middle tower" do
      moves = [[0, 1], [0, 2], [1, 2], [0, 1], [2, 0], [2, 1], [0, 1]]
      moves.each do |from, to|
        game.move_disc(from, to)
      end

      expect(game.won?).to be(true)
    end

    it "returns true when all the discs are on the last tower" do
      moves = [[0, 2], [0, 1], [2, 1], [0, 2], [1, 0], [1, 2], [0, 2]]
      moves.each do |from, to|
        game.move_disc(from, to)
      end

      expect(game.won?).to be(true)
    end

  end


end
