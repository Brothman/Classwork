require_relative 'tic_tac_toe'
require "byebug"

#iterate through all positions that are empty?
#For each empty position, create a node by duping the board and putting a next_mover_mark in the position
  #You'll want to alternate next_mover_mark so that next time the other player gets to move.
#set prev_move_pos to the position you just marked,

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    next_move = :o
    if @next_mover_mark == :x
      next_move = :o
    else
      next_move = :x
    end
    @board.rows.each.with_index do |row, i|
      row.each.with_index do |square, j|
        if square.nil?
          @board[i][j]= TicTacToeNode.new(board, next_move , [i, j])
          #square.board = board 
          debugger
        end
      end
    end
  end
end
