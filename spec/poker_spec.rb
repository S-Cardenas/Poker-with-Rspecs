require "poker.rb"

#cards
  #suits
  #values
  #points

describe Card do
  let(:card) {Card.new(:spade, :deuce)}

  describe "#initialize" do

    it 'has a suit' do
      expect(card.suit).to eq(:spade)
    end

    it 'has a value' do
      expect(card.value).to eq(:deuce)
    end

  end

end

#deck
  #hold 52 cards
  #deal
  #count

describe Deck do
  let(:deck) {Deck.new}

  describe "#initialize" do

    it "holds the cards in an array" do
      expect(deck.deck).to be_an(Array)
    end

    it "has the instance varible @deck" do
      ivar = deck.instance_variable_get(:@deck)
      expect(deck.deck).to eq(ivar)
    end

    it "only has Cards in the deck" do
      deck.deck.each do |card|
        expect(card).to be_a(Card)
      end
    end

  end

  describe "#count" do
    it 'has 52 cards' do
      expect(deck.count).to eq(52)
    end
  end

  describe "#shuffle" do
    it "shuffles the deck" do
      expect(deck.deck).to_not eq(deck.shuffle)
    end
  end

  describe "#deal" do
    it "return an array of cards" do
      expect(deck.deal(1)).to be_an(Array)
    end

    it "return an array of cards" do
      expect(deck.deal(1)[0]).to be_an(Card)
    end

    it "deals a specified number of cards" do
      expect(deck.deal(2).length).to eq(2)
    end

    it "it defaults to dealing 5 cards" do
      expect(deck.deal.length).to eq(5)
    end
  end

end

#players
  #init
  #bet
  #receive money
  #has a hand
  #fold
  #raise
  #stand
  #draw_cards
  #add_cards
  #remove_cards
  #points

describe Player do
  subject(:cardguy) { Player.new('cardguy', 20) }

  describe "#initialize" do

    it 'has a name' do
      ivar = cardguy.instance_variable_get(:@name)
      expect(cardguy.name).to eq(ivar)
    end

    it 'has a hand' do
      ivar = cardguy.instance_variable_get(:@hand)
      expect(cardguy.hand).to eq(ivar)
    end

    it 'has a wallet' do
      ivar = cardguy.instance_variable_get(:@wallet)
      expect(cardguy.wallet).to eq(ivar)
    end

  end

  describe "#place_bet" do

    it "stops you if player bets more than he has" do
      expect { cardguy.place_bet(30) }.to raise_error(CardError)
    end

    it "lowers your wall by bet amount" do
      cardguy.place_bet(5)
      expect(cardguy.wallet).to eq(15)
    end

    it "returns the ammount you bet" do
      expect(cardguy.place_bet(5)).to eq(5)
    end

  end

  describe "#recieve_money" do
    it "adds the recieved money to the wallet" do
      cardguy.recieve_money(10)
      expect(cardguy.wallet).to eq(30)
    end

    it "doesnt let you receive negative monies" do
      expect { cardguy.recieve_money(-10) }.to raise_error(CardError)
    end
  end

  describe "#add_cards" do
    let(:card0) { double("card0") }
    let(:card1) { double("card1") }

    it "can only add upto five cards to your hand" do
      expect { cardguy.add_cards([1,2,3,4,5,6]) }.to raise_error(CardError)
    end

    it 'the cards get added to the hand' do
      cardguy.add_cards([card0, card1])
      [card0, card1].each do |card|
        expect(cardguy.hand.include?(card)).to be true
      end
    end

  end

  describe "#remove_card" do
    let(:card0) { double("card0") }
    let(:card1) { double("card1") }

    it "raises an error if the card isn't there" do
      expect { cardguy.remove_card(card0) }.to raise_error(CardError)
    end

    it "removes a card from the hand" do
      cardguy.add_cards([card0])
      cardguy.remove_card(card0)
      expect(cardguy.hand.include? card0).to be false
    end

  end
end

describe Game do

  subject(:game) {Game.new(["Tom", "Mark", "Joe"],200)}

  describe "#initialize" do

    it 'creates an array of players' do
      expect(game.players).to be_an(Array)
      game.players.each do |player|
        expect(player).to be_a(Player)
      end
    end

  end

  describe "#switch_player" do

    it 'moves to the next player' do
      next_player = game.players[1]
      game.switch_player
      current_player = game.players[0]

      expect(next_player).to eq(current_player)
    end

  end

  describe "#current_player" do

    it 'moves to the next player' do
      current = game.players[0]
      expect(game.current_player).to eq(current)
    end

  end

  describe "#deal_initial_cards" do

    it "deals every player five cards" do
      game.deal_initial_cards
      game.players.each do |player|
        expect(player.hand.length).to eq(5)
      end
    end

  end
end


#hand
  #init
