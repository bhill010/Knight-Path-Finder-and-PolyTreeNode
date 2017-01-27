require-relative "00_tree_node"

class KnightPathFinder
  def initialize(arr)
    @root = PolyTreeNode.new(arr)
  end
end
