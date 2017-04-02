//: Playground - noun: a place where people can play

import Foundation

class Vertex<T> {
    
    var value: T
    var parent: Vertex<T>? = nil

    private var nextSibling: Vertex<T>? = nil
    private var previousSibling: Vertex<T>? = nil
    
    private var firstChild: Vertex<T>? = nil
    private var lastChild: Vertex<T>? = nil
    
    var height: Int {
        var height = 0
        var currentChild = firstChild
        while let child = currentChild {
            height = max(height, child.height + 1)
            currentChild = child.nextSibling
        }
        return height
    }
    
    var depth: Int {
        var depth = 0
        depth = (parent?.depth ?? -1) + 1
        return depth
    }
    
    init(value: T) {
        self.value = value
    }
    
    func addChild(_ vertex: Vertex<T>) {
        vertex.parent = self
        vertex.previousSibling = lastChild
        lastChild?.nextSibling = vertex
        lastChild = vertex
        if firstChild == nil {
            firstChild = lastChild
        }
    }
    
    func removeFromParent() {
        let nextSibling = self.nextSibling
        let previousSibling = self.previousSibling
        previousSibling?.nextSibling = nextSibling
        nextSibling?.previousSibling = previousSibling

        if parent?.lastChild === self {
            parent?.lastChild = previousSibling
        }
        
        if parent?.firstChild === self {
            parent?.firstChild = nextSibling
        }
        
        parent = nil
    }
    
    func traversal() -> [T] {
        var output = [value]
        
        var current = firstChild
        while let vertex = current {
            let values = vertex.traversal()
            output.append(contentsOf: values)
            current = vertex.nextSibling
        }
        
        return output
    }
}

class Tree<T> {
    var root: Vertex<T>?
    init(root: Vertex<T>? = nil) {
        self.root = root
    }
}

let a = Vertex(value: "A")
let b = Vertex(value: "B")
let c = Vertex(value: "C")
let d = Vertex(value: "D")
let e = Vertex(value: "E")
let f = Vertex(value: "F")

d.addChild(b)
d.addChild(e)
b.addChild(a)
b.addChild(c)
e.addChild(f)

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

root.traversal() == ["D", "B", "A", "C", "E", "F"]




