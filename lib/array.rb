
class TowersOfHanoi
  attr_reader :towers

  def initialize
    @towers =[[],[]]
    @full_tower = [3,2,1]
    @towers.unshift @full_tower
  end

  def move_disc(from, to)
    raise HanoiError.new('No disc.') if @towers[from].empty?
    if !@towers[to].empty? && @towers[to].last < @towers[from].last
      raise HanoiError.new "You can't place a larger disc on smaller disc."
    end
    disc = @towers[from].pop
    @towers[to].push(disc)
  end

  def won?
    @towers[1..-1].each do |tower|
      return true if tower == @full_tower
    end
    false
  end

  def run
    until won?
      p @towers
      take_turn
    end
    puts "yay!"
  end

  def take_turn
    reply = get_input
    move_disc(*reply)
  rescue HanoiError => e
    puts e.message
    retry
  end

end

class HanoiError < StandardError

end


class Array
  def my_uniq
    uniques = []
    each { |el| uniques << el unless uniques.include?(el) }
    uniques
  end

  def two_sum
    indices = []
    self.each_with_index do |el1, idx1|
      drop(idx1 + 1).each_with_index do |el2, idx2|
        indices << [idx1, idx1 + idx2 + 1] if el1 + el2 == 0
      end
    end
    indices
  end

  def my_transpose
    raise IndexError unless all? { |row| row.length == first.length }
    first.length.times.map { |y| length.times.map { |x| self[x][y] }}
  end

end

def stock_picker(array)
  bestdays = nil
  current_best = nil
  array.each_with_index do |buy, day1|
    array.drop(day1 + 1).each_with_index do |sell, day2|
      if !current_best
        current_best = sell - buy
        bestdays = [day1, day2 + day1 + 1]
      elsif (sell - buy) > current_best
        current_best = sell - buy
        bestdays = [day1, day2 + day1 + 1]
      end
    end
  end
  bestdays
end
