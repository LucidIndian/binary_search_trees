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

  # build_tree should return the level-0 root node.
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

  # pretty_print method from a TOP student
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert_rec(value, root = @root)
    if root.nil? # base case
      new_node = Node.new(value)
      return new_node
    elsif value == root.data
      puts "No duplicates allowed"
    elsif value < root.data
      root.left = insert_rec(value, root.left)
    elsif value > root.data
      root.right = insert_rec(value, root.right)
    end
    root
  end

  def delete_rec(value, root = @root)
    return if root.nil? # base case nothing found

    if value < root.data
      root.left = delete_rec(value, root.left)
    elsif value > root.data
      root.right = delete_rec(value, root.right)
    else # the node matches, so delete
      # node has 0 or only right child
      return root.right if root.left.nil?
      # node has only left child
      return root.left if root.right.nil?
      
      # Node to be deleted has 2 children:
        # - Find inorder successor of the node.
        succ_node = min_node(root.right)
        root.data = succ_node.data
        # - Copy contents of the inorder successor to the node and 
        # - delete the inorder successor.
        root.right = delete_rec(root.data, root.right)
        # - inorder successor can be obtained by 
        # finding the minimum value in the right child of the node.
    end  
      root
  end

  def min_node(root)
    min_root = root
    while !root.left.nil? do # there's smaller in the left?
      min_root = root.left # update with a smaller value
      root = root.left # assigning new root, to keep searching
    end
    min_root
  end

end

array = [6345, 1, 14, 44, 23, 8, 0, 3, 50, 7, 9, 67, 324]

bst = Tree.new(array)
bst.pretty_print
bst.insert_rec(500)
bst.pretty_print
bst.delete_rec(50)
bst.pretty_print
