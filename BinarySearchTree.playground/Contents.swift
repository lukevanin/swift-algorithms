//
//  Binary Search Tree (BST)
//      Binary tree
//      All values on left branch are smaller than the node value
//      All values on the right branch are larger than the node value
//

import Foundation

class Node {
    var value: Int
    var parent: Node? = nil
    var left: Node? = nil
    var right: Node? = nil
    
    var values: [Int] {
        var output = [Int]()
        
        if let left = left {
            output.append(contentsOf: left.values)
        }
        
        output.append(value)
        
        if let right = right {
            output.append(contentsOf: right.values)
        }
        
        return output
    }
    
    init(value: Int, parent: Node? = nil) {
        self.value = value
        self.parent = parent
    }
    
    func insert(value: Int) {
        if value < self.value {
            if let node = left {
                node.insert(value: value)
            }
            else {
                left = Node(value: value, parent: self)
            }
        }
        else if value > self.value {
            if let node = right {
                node.insert(value: value)
            }
            else {
                right = Node(value: value, parent: self)
            }
        }
    }
    
    func contains(value: Int) -> Bool {
        return node(with: value) != nil
    }
    
    func delete(value: Int) {
        guard let node = self.node(with: value) else {
            return
        }
        
        node.removeFromParent()
    }
    
    func removeFromParent() {
        
        if left != nil && right != nil {
            // Case 3: Two children
            let minNode = right!.min()
            self.value = minNode.value
            minNode.removeFromParent()
        }
        else if let node = left ?? right {
            // Case 2: One child
            if isLeft() {
                parent?.left = node
            }
            else if isRight() {
                parent?.right = node
            }
            unlink()
        }
        else {
            // Case 1: No children
            unlink()
        }
    }
    
    private func min() -> Node {
        var current = self
        while let node = current.left {
            current = node
        }
        return current
    }
    
    private func isLeft() -> Bool {
        return parent?.left === self
    }
    
    private func isRight() -> Bool {
        return parent?.right === self
    }
    
    private func unlink() {
        if isLeft() {
            parent?.left = nil
        }
        
        if isRight() {
            parent?.right = nil
        }
        
        parent = nil
    }
    
    private func node(with value: Int) -> Node? {
        if value < self.value {
            return left?.node(with: value)
        }
        
        if value > self.value {
            return right?.node(with: value)
        }
        
        return self
    }
}

let root = Node(value: 5)
root.insert(value: 3)
root.insert(value: 8)
root.insert(value: 1)
root.insert(value: 7)
root.insert(value: 10)
root.insert(value: 8)

root.values == [1, 3, 5, 7, 8, 10]
root.insert(value: 4)
root.values == [1, 3, 4, 5, 7, 8, 10]

root.contains(value: 3) == true
root.contains(value: 1) == true
root.contains(value: 0) == false
root.contains(value: 12) == false

root.values

root.delete(value: 8)
root.values

root.delete(value: 3)
root.values

root.insert(value: 8)
root.values
