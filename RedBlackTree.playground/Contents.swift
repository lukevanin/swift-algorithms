//
//  Red-Black Tree
//      https://en.wikipedia.org/wiki/Red–black_tree
//      Binary Search Tree.
//      Self balancing.
//      Tries to minimize the number of levels it uses.
//      
//      Rule 1: Nodes must be either red or black.
//      Rule 2: Every node must have null children. All null child nodes are black.
//      Rule 3: If a node is red, all of its leaf nodes must be black.
//      Rule 4: (optional) Root node is always black.
//      Rule 5: Every path from a node to its descendant null nodes must contain the same number of black nodes.
//
//      Insertion and deletion in worst case: O(log n)
//
//      Insertion:
//          Insert red new node as red node. Change color afterwards.
//          Case 1: Insert first node into tree. Change node to black according to rule 4 (optional).
//          Case 2: If the parent of the new node is black then the tree is valid.
//          Case 3: If the parent of the new node is red and its sibling is red, then
//                      Both parent and its sibling change to black, and
//                      The parent's parent (grandparent) changes to red.
//                      Recurse up tree.
//                      (optional) If the grandparent is the root then it changes back to black.
//          Case 4: Parent is red and its sibling is black.
//                      Red node and its red parent are not on the same side of their parent.
//                      i.e. Node is right child, and its parent is a left child.
//                      Perform left rotation on parent.
//          Case 5: Parent is red and its sibling is black.
//                      Red node and its red parent are on the same side of their parent.
//                      i.e. Node is a left child and its parent is a left child.
//                      Right rotation on grandparent.
//

import Foundation

enum Color: CustomStringConvertible {
    case red
    case black
    
    var description: String {
        switch self {
        case .red:
            return "🔺"
            
        case .black:
            return "▪️"
        }
    }
}

class Node: CustomStringConvertible {
    var value: Int
    var color: Color
    var left: Node?
    var right: Node?
    var parent: Node?
    
    var description: String {
        return "<\(value)\(color)>"
    }

    init(value: Int, color: Color) {
        self.value = value
        self.color = color
    }
}

class RedBlackTree {
    
    var summary: String {
        let nodes = traverse()
        let values = nodes.map({ String(describing: $0) })
        return "[" + values.joined(separator: ", ") + "]"
    }
    
    var root: Node?
    
    func insert(_ value: Int) {
        guard let node = root else {
            // Rule 4: Root node must be black.
            print("Inserting new node \(value) at root")
            let newNode = Node(value: value, color: .red)
            root = newNode
            insertCase1(node: newNode)
            return
        }
        
        insert(value: value, at: node)
    }
    
    func traverse() -> [Node] {
        var output = [Node]()
        var stack = [Node]()
        var current = root
        
        while true {
            
            if let node = current {
                stack.append(node)
                current = node.left
            }
            else {
                if let node = stack.popLast() {
                    if output.contains(where: { $0 === node }) {
                        fatalError("Tree contains cycle for node \(node)")
                    }
                    output.append(node)
                    current = node.right
                }
                else {
                    break;
                }
            }
        }
        
        return output

    }
    
    func insert(value: Int, at node: Node) {

        var newNode: Node?
        
        if value < node.value {
            if let left = node.left {
                print("Inserting \(value) at left of node \(node)")
                insert(value: value, at: left)
            }
            else {
                print("Inserting new node \(value) at left of node \(node)")
                newNode = Node(value: value, color: .red)
                newNode?.parent = node
                node.left = newNode
            }
        }
        else if value > node.value {
            if let right = node.right {
                print("Inserting \(value) at right of node \(node)")
                insert(value: value, at: right)
            }
            else {
                print("Inserting new node \(value) at right of node \(node)")
                newNode = Node(value: value, color: .red)
                newNode?.parent = node
                node.right = newNode
            }
        }
        else {
            return
        }
        
        if let node = newNode {
            insertCase1(node: node)
        }
    }
    
    //
    //  Case 1: Node is a root node. Recolor the node to black.
    //
    func insertCase1(node: Node) {
        
        let nodeValue = String(describing: node)
        let parentValue: String
        if let parent = node.parent {
            parentValue = String(describing: parent)
        }
        else {
            parentValue = "none"
        }
        print("Balancing node [\(nodeValue)] P: \(parentValue)")
        
        guard let parent = node.parent else {
            // Node is root node.
            print(" Case 1: Node is root. Recolor to black.")
            node.color = .black
            return
        }
        
        insertCase2(node: node, parent: parent)
    }
    
    //
    //  Case 2: The parent of the node is black.
    //
    func insertCase2(node: Node, parent: Node) {
        
        print(" Check case 2: Parent")

        if parent.color == .black {
            // Node's parent is black
            print(" Case 2: Node's parent is black.");
            return
        }
        
        guard let grandparent = parent.parent else {
            // Invalid tree structure. 
            // The grandparent must exist. The parent node is red so it must have a black parent.
            print("Node's grandparent is nil");
            fatalError("Invalid tree structure")
        }
        
        insertCase3(node: node, parent: parent, grandparent: grandparent)
    }
    
    //
    //  Case 3: Both the parent and uncle are red, then
    //      Both parent and sibling must be recolored to black, and
    //      Grandparent recolored must be recolored red.
    //      Rules from rule 1 are recursively applied to grandparent.
    //
    func insertCase3(node: Node, parent: Node, grandparent: Node) {
        
        print(" Check case 3")

        if let uncle = sibling(of: parent) {
            // Node's parent is red. Check if parent's sibling is also red.
            if uncle.color == .red {
                print(" Case 3: Node's parent and uncle are red. Recolor parent and uncle red. Recurse from grandparent with case 1.")
                parent.color = .black
                uncle.color = .black
                insertCase1(node: grandparent)
                return
            }
        }
        insertCase4(node: node, parent: parent, grandparent: grandparent)
    }
    
    //
    //  Case 4: The parent is red, and the uncle is black.
    //      The node and its parent are on different sides of their parents 
    //      If the node is a right node and its parent is a left node, then perform a left rotation on parent.
    //      If the node is a left node and its parent is a right node, the perform a right rotation on parent.
    //
    func insertCase4(node: Node, parent: Node, grandparent: Node) {
        
        print(" Check case 4")

        var newNode = node
        var newParent = parent
        
        if isRight(node: node) && isLeft(node: parent) {
            print(" Case 4: Node is a right child, and node's parent is a left child. Rotate left on parent.")
            rotateLeft(node: node, parent: parent)
            newNode = parent
            newParent = node
        }
        else if isLeft(node: node) && isRight(node: parent) {
            print(" Case 4: Node is a left child, and node's parent is a right child. Rotate right on parent.")
            rotateRight(node: node, parent: parent)
            newNode = parent
            newParent = node
        }
        
        insertCase5(node: newNode, parent: newParent, grandparent: grandparent)
    }
    
    //
    //  Case 5: The parent is red, and the uncle is black.
    //      Node and parent are on the same side of their parent's.
    //      If node and parent are both a left child, perform right rotation on grandparent.
    //      If node and parent are both a right child, perform a left rotation on grandparent.
    //      After rotation:
    //          Parent becomes new parent of node and grandparent.
    //          Parent is known to be red, grandparent is known to be black.
    //          Switch colors of parent and grandparent (parent becomes black, grandparent is red, node is red).
    //
    func insertCase5(node: Node, parent: Node, grandparent: Node) {
        
        print(" Check case 5")

        parent.color = .black
        grandparent.color = .red
        if isLeft(node: node) {
            print(" Case 5: Node \(node) and parent \(parent) are both left children. Rotate right on grandparent \(grandparent).")
            rotateRight(node: parent, parent: grandparent)
        }
        else if isRight(node: node) {
            print(" Case 5: Node \(node) and parent \(parent) are both right children. Rotate left on grandparent \(grandparent).")
            rotateLeft(node: parent, parent: grandparent)
        }
        else {
            fatalError("Node is neither left nor right. Node: \(node). Parent: \(parent). Parent.left: \(parent.left). Parent.right: \(parent.right)")
        }
    }
    
    func rotateLeft(node oldNode: Node, parent oldParent: Node) {
        
        let newParent = oldNode
        let newNode = oldParent
        
        print("Rotate left.")
        print(" from N: \(oldNode). P: \(oldParent)")
        print(" to   N: \(newNode). P: \(newParent)")
        
        let oldNodeLeft = oldNode.left
        let oldNodeRight = oldNode.right
        let oldParentLeft = oldParent.left
        
        replace(node: oldParent, with: newParent)
        newParent.left = oldParent
        newParent.right = oldNodeRight
        
        newNode.parent = newParent
        newNode.left = oldParentLeft
        newNode.right = oldNodeLeft
    }
    
    func rotateRight(node oldNode: Node, parent oldParent: Node) {
        
        let newParent = oldNode
        let newNode = oldParent
        
        print("Rotate right.")
        print(" from N: \(oldNode). P: \(oldParent)")
        print(" to   N: \(newNode). P: \(newParent)")
        
        let oldNodeLeft = oldNode.left
        let oldNodeRight = oldNode.right
        let oldParentRight = oldParent.right
        
        replace(node: oldParent, with: newParent)
        newParent.left = oldNodeLeft
        newParent.right = oldParent

        newNode.parent = newParent
        newNode.left = oldNodeRight
        newNode.right = oldParentRight
    }
    
    func replace(node oldNode: Node, with newNode: Node) {

        if let ancestor = oldNode.parent {

            if isLeft(node: oldNode) {
                print(" Setting ancestor left from \(oldNode) to \(newNode)")
                ancestor.left = newNode
            }
            else if isRight(node: oldNode) {
                print(" Setting ancestor right from \(oldNode) to \(newNode)")
                ancestor.right = newNode
            }
            else {
                print("Node is neither left or right")
            }
            
            print(" Setting ancestor for node \(newNode) to \(ancestor)")
            newNode.parent = ancestor
        }
        else {
            print(" Setting root node to node \(newNode)")
            root = newNode
            newNode.parent = nil
        }
        
        oldNode.parent = nil
    }
    
    func grandparent(of node: Node?) -> Node? {
        return node?.parent?.parent
    }
    
    func isLeft(node: Node?) -> Bool {
        return node?.parent?.left === node
    }
    
    func isRight(node: Node?) -> Bool {
        return node?.parent?.right === node
    }
    
    func sibling(of node: Node?) -> Node? {
        if isLeft(node: node) {
            return node?.parent?.right
        }
        
        if isRight(node: node) {
            return node?.parent?.left
        }
        
        return nil
    }
    
    func uncle(of node: Node?) -> Node? {
        return sibling(of: node?.parent)
    }
}

var tree = RedBlackTree()

tree.insert(5)
tree.insert(1)
tree.insert(8)
tree.insert(3)
tree.insert(2)
tree.insert(11)
tree.insert(9)
tree.insert(7)
tree.insert(4)

tree.summary


