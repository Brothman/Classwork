require_relative "00_tree_node.rb"
require 'byebug'
class KnightPathFinder
  attr_accessor :move_tree

  def initialize(starting_pos = [0,0])
    @visited_positions =[starting_pos]
    @current_position = starting_pos
    build_move_tree(starting_pos)
  end

  def self.valid_moves?(pos)
    x,y = pos
    valid_range = (0..7).to_a
    valid_range.include?(x) && valid_range.include?(y)
  end

  def self.valid_moves(pos)
    x,y = pos
    possible_positions = [
      [x-2, y-1],
      [x-2, y+1],
      [x+2, y+1],
      [x+2, y-1],
      [x+1, y+2],
      [x-1, y+2],
      [x-1, y-2],
      [x+1, y-2]
    ]
    valid_positions = possible_positions.select {|pos| KnightPathFinder.valid_moves?(pos) }
  end

  def new_move_positions(pos)
    valid_positions = KnightPathFinder.valid_moves(pos)
    valid_positions = valid_positions.select {|pos| !@visited_positions.include?(pos)}
    @visited_positions.concat(valid_positions)
    valid_positions
  end

  def build_move_tree(starting_pos)
    #debugger
    root = PolyTreeNode.new(starting_pos)
    queue = [root]
    @move_tree = root

    until queue.empty?
      current_node = queue.shift
      possible_children = new_move_positions(current_node.value)
      possible_children.each do |child_move|
        child = PolyTreeNode.new(child_move)
        current_node.add_child(child)
      end

      queue.concat(current_node.children)
    end

#    @move_tree = root
  end

  def find_path(end_pos)
    end_pos_node = @move_tree.bfs(end_pos)
    trace_path_back(end_pos_node)
  end

  def trace_path_back(node)
    path = []
    until node == @move_tree
      path.unshift(node)
      node = node.parent
    end
    path.unshift(@move_tree)
    #debugger
    path
  end
end

  Knight = KnightPathFinder.new([0,0])
  # Knight.build_move_tree
  #puts Knight.move_tree.children.map(&:value)
  p Knight.find_path([7, 6]).map(&:value)

#https://www.amazon.com/Better-Angels-Our-Nature-Violence/dp/0143122010
#https://www.amazon.com/Rational-Optimist-Prosperity-Evolves-P-s/dp/0061452068
