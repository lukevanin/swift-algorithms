//
//  Binary tree
//
import Foundation

class Vertex<T> {
    
    typealias Iterator = (Vertex<T>) -> Void
    
    var value: T
    
    var parent: Vertex<T>? = nil
    var left: Vertex<T>? = nil
    var right: Vertex<T>? = nil
    
    var height: Int {
        let leftHeight = (left?.height ?? -1) + 1
        let rightHeight = (right?.height ?? -1) + 1
        return max(leftHeight, rightHeight)
    }
    
    var depth: Int {
        var depth = 0
        depth = (parent?.depth ?? -1) + 1
        return depth
    }
    
    init(value: T, left: Vertex<T>? = nil, right: Vertex<T>? = nil) {
        self.value = value
        self.left = left
        self.right = right
        self.left?.parent = self
        self.right?.parent = self
    }
    
    
    //
    //  Visit all nodes on level before proceeding to next level
    //
    func levelOrderTraversal(_ iterator: Iterator) {
        var currentLevel = [self]
        var nextLevel = [Vertex<T>]()
        
        repeat {
            for node in currentLevel {
                iterator(node)
                if let left = node.left {
                    nextLevel.append(left)
                }
                if let right = node.right {
                    nextLevel.append(right)
                }
            }
        
            currentLevel = nextLevel
            nextLevel.removeAll()
        } while currentLevel.count > 0
    }
    
    //
    //  Visit nodes in order of current, left, right
    //  Depth-first
    //
    func preOrderTraversal(_ iterator: Iterator) {
        iterator(self)
        left?.preOrderTraversal(iterator)
        right?.preOrderTraversal(iterator)
    }
    
    //
    //  Visit nodes in order of left, current, right
    //  Depth-first
    //
    func inOrderTraversal(_ iterator: Iterator) {
        left?.inOrderTraversal(iterator)
        iterator(self)
        right?.inOrderTraversal(iterator)
    }
    
    //
    //  Visit nodes in order of left, right, current
    //  Depth-first
    //
    func postOrderTraversal(_ iterator: Iterator) {
        left?.postOrderTraversal(iterator)
        right?.postOrderTraversal(iterator)
        iterator(self)
    }
    
    //
    //  Returns the current vertex if it is a leaf, otherwise the first descendant leaf.
    //  A leaf is a node which has no child nodes.
    //
    func firstLeaf() -> Vertex<T> {
        if let leaf = left?.firstLeaf() {
            return leaf
        }
        
        if let leaf = right?.firstLeaf() {
            return leaf
        }
        
        return self
    }
    
    //
    //  Removes node from parent node. 
    //  The node's position is filled by the first leaf descendant (empty) node.
    //
    func removeFromParent() {
        
        let leaf = firstLeaf()
        if leaf !== self {
            
            // Remove links from leaf's parent to leaf.
            if leaf.parent?.left === leaf {
                leaf.parent?.left = nil
            }
            
            if leaf.parent?.right === leaf {
                leaf.parent?.right = nil
            }
            
            // Remove links from node's parent to node.
            if self.parent?.left === self {
                self.parent?.left = leaf
            }
            
            if self.parent?.right === self {
                self.parent?.right = leaf
            }
            
            // Link leaf in node's place.
            leaf.parent = parent
            leaf.left = self.left
            leaf.right = self.right
        }
        
        parent = nil
        left = nil
        right = nil
    }
    
    //
    //  Inserts a node as a descendant of the current node. 
    //  If the node has an empty branch then it is filled with the new node.
    //  If both branches are filled, then the insertion continues recursively to the left child.
    //
    func insert(value: T) {
        if left == nil || right == nil {
            let node = Vertex(value: value)
            node.parent = self
            if left == nil {
                left = node
            }
            else if right == nil {
                right = node
            }
        }
        else {
            left?.insert(value: value)
        }
    }
}

extension Vertex where T: Equatable {

    //
    //  Returns a node with a matching value if any.
    //
    func find(value: T) -> Vertex<T>? {
        if self.value == value {
            return self
        }
        
        if let left = left?.find(value: value) {
            return left
        }
        
        if let right = right?.find(value: value) {
            return right
        }
        
        return nil
    }
    
    //
    //  Deletes a node with a given value. 
    //  Returns the deleted node.
    //
    func delete(value: T) -> Vertex<T>? {
        guard let node = find(value: value) else {
            return nil
        }
        
        node.removeFromParent()
        return node
    }
}

let a = Vertex(value: "A")
let c = Vertex(value: "C")
let b = Vertex(value: "B", left: a, right: c)
let f = Vertex(value: "F")
let e = Vertex(value: "E", right: f)
let d = Vertex(value: "D", left: b, right: e)

a.height == 0
b.height == 1
c.height == 0
d.height == 2
e.height == 1
f.height == 0

a.depth == 2
b.depth == 1
c.depth == 2
d.depth == 0
e.depth == 1
f.depth == 2

let root = d

var levelOrder = [String]()
root.levelOrderTraversal() { levelOrder.append($0.value) }
levelOrder == ["D", "B", "E", "A", "C", "F"]

var preOrder = [String]()
root.preOrderTraversal() { preOrder.append($0.value) }
preOrder == ["D", "B", "A", "C", "E", "F"]

var inOrder = [String]()
root.inOrderTraversal() { inOrder.append($0.value) }
inOrder  == ["A", "B", "C", "D", "E", "F"]

var postOrder = [String]()
root.postOrderTraversal() { postOrder.append($0.value) }
postOrder  == ["A", "C", "B", "F", "E", "D"]

root.delete(value: "B")

var nodes1 = [String]()
root.levelOrderTraversal() { nodes1.append($0.value) }
nodes1

root.insert(value: "G")

var nodes2 = [String]()
root.levelOrderTraversal() { nodes2.append($0.value) }
nodes2



