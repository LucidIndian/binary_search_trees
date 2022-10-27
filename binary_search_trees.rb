class Node

  attr_accessor :data, :right, :left

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left # child
    @right = right # child
  end

end   


class Tree

  attr_accessor :root

  def initialize(array)
    @array = array.sort # sorted array required for build_tree (BST)
    @root = build_tree(@array)
  end

  # method should return the level-0 root node.
  def build_tree(array, start_ind = 0, end_ind = array.length - 1)
    # base case for recursion
    return nil if start_ind > end_ind
    # make middle element the root   
    mid_ind = (start_ind + end_ind) / 2
    root = Node.new(array[mid_ind])
    # puts "the root is #{root}, at index #{mid_ind}"
    root.left = build_tree(array, start_ind, mid_ind - 1)
    root.right = build_tree(array, mid_ind + 1, end_ind)
    # puts "left_subtree #{p left_subtree}"
    # puts "right_subtree #{p right_subtree}"
    root
  end

  # pretty_print method from TOP student
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end   

array = [6345, 1, 13, 44, 23, 8, 0, 3, 50, 7, 9, 67, 324]

bst = Tree.new(array)
bst.pretty_print