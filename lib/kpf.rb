require_relative "00_tree_node"

class KnightPathFinder
  attr_reader :root, :visited_positions, :position, :board
  MOVES = [
    [1, 2],
    [1, -2],
    [2, 1],
    [2, -1],
    [-1, 2],
    [-1, -2],
    [-2, 1],
    [-2, -1]
    ]

  def initialize(arr)
    @visited_positions = [arr]
    @root = build_move_tree(PolyTreeNode.new(arr))
    @board = Array.new(8) { Array.new(8) }
  end

  def build_move_tree(root)
    queue = [root]

    until queue.empty?
      current_node = queue.shift
      new_move_positions(current_node.value).each do |move|
        current_node.add_child(PolyTreeNode.new(move))
      end

      queue += current_node.children
    end
    
    root
  end

  def self.valid_moves(pos)
    spots = MOVES.map { |el| [ el[0] + pos[0], el[1] + pos[1] ] }
    spots.select { |el| ((0..7).include? el[0]) && ((0..7).include? el[1]) }
  end

  def new_move_positions(pos)
    new_positions = []
    KnightPathFinder.valid_moves(pos).each do |el|
      new_positions << el unless @visited_positions.include?(el)
    end
    @visited_positions.concat(new_positions)
    new_positions
  end

  def find_path(end_pos)
    trace_path_back(@root.dfs(end_pos))
  end

  def trace_path_back(node)
    result = [node.value]

    current_node = node
    until current_node == root
      current_node = current_node.parent
      result << current_node.value
    end
    result.reverse
  end
end
