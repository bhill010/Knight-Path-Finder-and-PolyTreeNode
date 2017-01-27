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
    @root = build_move_tree(PolyTreeNode.new(arr))
    @visited_positions = [arr] #Maybe nodes
    #@position = arr
    @board = Array.new(8) { Array.new(8) }
  end

  def build_move_tree(root)
    queue = [root]

    until queue.empty?
      current_node = queue.shift
      ##do something
      new_move_positions(root).each do |move|
        root.add_child(PolyTreeNode.new(move))
      end

      queue += current_node.children
    end
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
end
