class Array
  def my_uniq
    my_arr = Array.new
    self.each do |el|
      my_arr << el unless my_arr.include?(el)
    end
    my_arr
  end

  def two_sum
    my_arr = Array.new
    (0..self.size - 2).each do |i|
      (i + 1..self.size - 1).each do |j|
        my_arr << [i, j] if (self[i] + self[j]).zero?
      end
    end
    my_arr
  end

  def my_transpose
    my_arr = Array.new
    self.each.with_index do |row, i|
      my_row = Array.new
      row.each.with_index do |col, j|
        my_row << self[j][i]
      end
      my_arr << my_row
    end
    my_arr
  end
end

def stock_picker(stocks)
  my_hash = Hash.new(0)
  my_hash[:buy] = [0, stocks[0]]
  my_hash[:buy_date] = 0
  #keys will days you want to buy
  (1..stocks.size - 2).each do |i|
    my_hash[:buy] << [i, stocks[i]]
    (i+1..stocks.size - 1).each do |j|
      if (stocks[j] - my_hash[:buy][-1][1]) > my_hash[:profit]
        my_hash[:buy_date] = my_hash[:buy][-1][0]
        my_hash[:sell] = [j, stocks[j]]
        my_hash[:profit] = stocks[j] - stocks[i]
      end
    end
  end
  [my_hash[:buy_date], my_hash[:sell][0]]
end


class TowersOfHanoi
  attr_reader :towers

  def initialize(towers = nil)
    towers ||= [
                [2,1,0],
                [],
                []
              ]
    @towers = towers
  end

  def move(from, to)
    valid_move?(from, to)
    piece = towers[from].pop
    towers[to] << piece
  end

  def valid_move?(from, to)
    raise "invalid move choice" unless from.between?(0, 2) && to.between?(0, 2)
    raise "invalid move choice" if (towers[from].size).zero?
    raise "invalid move choice" unless (towers[to].last).nil? || (towers[from].last < towers[to].last)
    true
  end

  def won?
    return false if towers[0].size > 0
    return false if towers[1].size > 0 && towers[2].size > 0
    true
  end

  def render
    system('clear')
    towers.each_with_index do |tower, idx|
      print idx
      puts "||" if tower.empty?

      tower.each do |disk|
        (disk + 1).times { print '|_|' }
        print disk + 1
      end
      puts
    end
  end

  def get_player_input
    begin
      puts "Move disk from which tower?_"
      from = gets.chomp.to_i
      puts "Move disk to which tower?_"
      to = gets.chomp.to_i

      move(from, to)
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def play
    until won?
      render
      get_player_input
    end
    game_over_message
  end

  def game_over_message
    puts "You won Towers of Hanoi. Good job!"

  end

end

towers = TowersOfHanoi.new

towers.play
