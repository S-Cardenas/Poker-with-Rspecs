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
  let(:towers) { game.towers }

  describe "#initalize" do

    it "creates a full first tower" do
      expect(towers.first).to eq([3,2,1])
    end

    it "has two empty towers" do
      expect(towers[1..-1]).to eq([[],[]])
    end

  end

  describe "#towers" do

    it "initializes towers instance variable" do
      ivar = game.instance_variable_get(:@towers)

      expect(towers).to eq(ivar)
    end

    it "it initializes @towers as an array" do
      expect(towers.class).to be(Array)
    end

    it "contains arrays" do
      expect(towers.all? {|tower| tower.is_a?(Array)}).to be(true)
    end

    it "holds only Fixums as discs" do
      towers.each do |tower|
        expect(tower.all? { |d| d.is_a? Fixnum }).to be(true)
      end
    end
  end

  describe "#move_disc" do

    it "pops the disk off a tower" do
      game.move_disc(0, 2)
      expect(towers.first).to eq([3, 2])
    end

    it "pushes the disk onto a tower" do
      game.move_disc(0, 2)
      expect(towers.last).to eq([1])
    end

    it "expects an error if you move large disc onto a small disk" do
      game.move_disc(0, 2)
      expect { game.move_disc(0, 2) }.to raise_error(HanoiError)
    end

    it "expects an error if you try to move form an empty tower" do
      expect { game.move_disc(1,3) }.to raise_error(HanoiError)
    end

  end


end
