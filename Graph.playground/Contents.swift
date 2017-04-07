//: Playground - noun: a place where people can play

import Foundation

class Vertex: CustomStringConvertible {
    var description: String {
        return value
    }
    let value: String
    var visited = false
    var vertices = [Vertex]()
    init(_ value: String) {
        self.value = value
    }
}

func breadthFirstTraversal(_ root: Vertex) -> [String] {
    var output = [String]()
    var queue = [Vertex]()
    
    queue.append(root)
    
    while let node = queue.popLast() {
        
        if !node.visited {
            node.visited = true
            output.append(node.value)
        }
        
        for vertex in node.vertices {
            if !vertex.visited {
                vertex.visited = true
                queue.insert(vertex, at: 0)
                output.append(vertex.value)
            }
        }
    }
    
    return output
}

func depthFirstTraversal(_ vertex: Vertex) -> [String] {
    var output = [String]()
    
    if !vertex.visited {
        output.append(vertex.value)
        vertex.visited = true
        
        for vertex in vertex.vertices {
            let values = depthFirstTraversal(vertex)
            output.append(contentsOf: values)
        }
    }
    
    return output
}

let g = Vertex("G")
let r = Vertex("R")
let a = Vertex("A")
let p = Vertex("P")
let h = Vertex("H")
let s = Vertex("S")

g.vertices.append(contentsOf: [h, a, r])
r.vertices.append(contentsOf: [p, a])
a.vertices.append(contentsOf: [g, r])
p.vertices.append(contentsOf: [r])
h.vertices.append(contentsOf: [g, s])

//breadthFirstTraversal(g)
depthFirstTraversal(g)

