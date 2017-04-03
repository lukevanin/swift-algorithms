//
//  Binary search tree
//      Based on: https://leetcode.com/problems/delete-node-in-a-bst/
//

import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class BST {
    
    var root: TreeNode?
    
    var values: [Int] {
        return values(root)
    }
    
    init() {
        self.root = nil
    }
    
    func values(_ root: TreeNode?) -> [Int] {
        var output = [Int]()
        if let node = root {
            if let left = node.left {
                output.append(contentsOf: values(left))
            }
            
            output.append(node.val)
            
            if let right = node.right {
                output.append(contentsOf: values(right))
            }
        }
        return output
    }
    
    func insert(_ value: Int) {
        root = insertNode(root, value)
    }
    
    func delete(_ value: Int) {
        root = deleteNode(root, value)
    }
    
    func insertNode(_ root: TreeNode?, _ value: Int) -> TreeNode? {
        guard let node = root else {
            return TreeNode(value)
        }
        
        if value < node.val {
            node.left = insertNode(node.left, value)
        }
        else if value > node.val {
            node.right = insertNode(node.right, value)
        }

        return node
    }
    
    func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
        guard let node = root else {
            return nil
        }
        
        if key < node.val {
            node.left = deleteNode(node.left, key)
        }
        else if key > node.val {
            node.right = deleteNode(node.right, key)
        }
        else {
            if node.left == nil {
                return node.right
            }
            else if node.right == nil {
                return node.left
            }
            
            let minNode = findMin(node.right!)
            node.val = minNode.val
            node.right = deleteNode(node.right, node.val)
        }
        
        return node
    }

    func findMin(_ node: TreeNode) -> TreeNode {
        if let leftNode = node.left {
            return findMin(leftNode)
        }
        return node
    }
}

let tree = BST()

// Create tree:
//
//      5
//     / \
//    3   6
//   / \   \
//  2   4   7

tree.insert(5)
tree.values

tree.insert(3)
tree.values

tree.insert(6)
tree.values

tree.insert(2)
tree.values

tree.insert(4)
tree.values

tree.insert(7)
tree.values

// Delete 3:
//
//      5
//     / \
//    4   6
//   /     \
//  2       7

tree.delete(3)
tree.values

// Delete 5:
//
//      6
//     / \
//    4   7
//   /
//  2

tree.delete(5)
tree.values


// Delete 4:
//
//      6
//     / \
//    2   7

tree.delete(4)
tree.values

// Insert values:
//
//        6
//       / \
//      2   7
//     / \
//    1   3
//         \
//          5

tree.insert(3)
tree.values

tree.insert(5)
tree.values

tree.insert(1)
tree.values
