require 'byebug'

class PolyTreeNode
  attr_accessor :node, :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent_node)
    if parent_node.nil?
      unless @parent.nil?
        @parent.children.delete(self)
        @parent = nil
      end
    else
      if @parent.nil?
        @parent = parent_node
        parent_node.children << self
      else
        @parent.children.delete(self)
        @parent = parent_node
        parent_node.children << self
      end
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if @children.include?(child_node)
      child_node.parent = nil
      @children.delete(child_node)
    else
      raise "not your child"
    end
  end


  def dfs(target_value)
    if value == target_value
      return self
    end

    children.each do |child|
      return_value = child.dfs(target_value)
      return return_value unless return_value.nil?
    end

    nil
  end

  def bfs(target_value)
    queue = Array.new

    queue.push(self)

    until queue.empty?
      node_to_check = queue.shift

      if node_to_check.value == target_value
        return node_to_check
      else
        queue.concat(node_to_check.children)
      end
    end
    nil
  end

end
