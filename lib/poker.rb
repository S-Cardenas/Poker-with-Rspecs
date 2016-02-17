class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

end

class Deck
  attr_reader :deck

  def initialize
    @deck = create_deck
    shuffle
  end

  def shuffle
    @deck.shuffle
  end

  def count
    @deck.length
  end

  def deal(n = 5)
    raise "not enough cards" if @deck.length < n
    cards = []
    n.times { cards << @deck.pop}
    cards
  end

  private

  def create_deck
    suits = [:hearts, :spades, :clubs, :diamonds]
    values = [:deuce, :three, :four, :five, :six, :seven, :eight,
              :nine, :ten, :jack, :queen, :king, :ace]
    suits.product(values).map do |suit, value|
      Card.new(suit, value)
    end
  end

end

class Player
  attr_reader :name, :wallet, :hand

  def initialize(name, wallet)
    @name = name
    @wallet = wallet
    @hand = []
  end

  def place_bet(n)
    raise CardError.new if n > @wallet
    @wallet -= n
    n
  end

  def recieve_money(n)
    raise CardError.new if n < 0
    @wallet += n
  end

  def add_cards(cards)
    raise CardError.new if cards.length + hand.length > 5
    @hand.push *cards
  end

  def remove_card(card)
    raise CardError.new unless @hand.include? card
    @hand.delete(card)
  end

end

class Game
  attr_reader :players

  def initialize(player_names, buyin)
    @players = player_names.length.times.map do |idx|
      Player.new(player_names[idx], buyin)
    end
    @deck = Deck.new
  end

  def current_player
    @players[0]
  end

  def switch_player
    @players.rotate!(1)
  end

  def deal_initial_cards
    @players.each do |player|
      player.add_cards(@deck.deal)
    end
  end
end

class CardError < StandardError
end
