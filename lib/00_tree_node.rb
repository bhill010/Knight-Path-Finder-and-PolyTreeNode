class PolyTreeNode

attr_accessor :parent, :children

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def value
    @value
  end

  def parent=(parent)
    @parent.children.delete(self) if @parent
    @parent = parent
    @parent.children += [self] if parent
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Node isn't my child" unless @children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if value == target_value

    @children.each do |node|
      result = node.dfs(target_value)
      return result if result
    end

    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end
    nil
  end



end
