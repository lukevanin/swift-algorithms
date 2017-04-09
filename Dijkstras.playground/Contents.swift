//: Playground - noun: a place where people can play

import Foundation

class MinQueue {
    
    var values = [Int : Int]()
    
    func set(value: Int, at index: Int) {
        values[index] = value
    }
    
    func value(at index: Int) {
        return values[index]
    }
    
    func extractMin() -> (Int?, Int?) {
        var key: Int?
        var min = Int.max
        
        for (k, v) in values {
            if v < min {
                min = v
                key = k
            }
        }
        
        guard let k = key, let v = values.removeValue(forKey: k) else {
            return (nil, nil)
        }
        
        return (k, v)
    }

}

class Graph {
    
    let values: [String]
    var matrix: [[Int?]]
    
    init(_ values: [String]) {
        self.values = values
        
        let count = values.count
        let row = [Int?](repeating: nil, count: count)
        let matrix = [[Int?]](repeating: row, count: count)
        self.matrix = matrix
    }
    
    func addEdge(from: Int, to: Int, weight: Int) {
        matrix[from][to] = weight
        matrix[to][from] = weight
    }
    
    func distance(from: Int, to: Int) -> Int? {
        return matrix[from][to]
    }
    
    func shortestPath(from: Int, to: Int) -> Int {
        var output = 0
        var queue = MinQueue()
        
        for i in 0 ..< values.count {
            queue.values[i] = Int.max
        }
        
        queue.values[from] = 0
        
        var next: Int? = from
        var distance: Int? = 0
        
        while let current = next, let total = distance, current != to {
            
            // For each adjacent vertex, calculate the distance from the origin to that vertex.
            // Update the queue if the distance is shorter than the current known distance.
            let edges = matrix[current]
            for i in 0 ..< edges.count {
                
                // Distance from current vertex to the adjacent vertex.
                guard let d = edges[i] else {
                    // No connection from node to edge.
                    continue
                }
                
                // Calculate total distance to the vertex.
                let t = total + d
                
                // Check if the total distance from the origin to the adjacent vertex 
                // is less than the smallest known distance.
                if let v = queue.values[i], t < v {
                    queue.values[i] = t
                }
            }
            
            // Get nearest node
            (next, distance) = queue.extractMin()
            
            if let distance = distance {
                output = distance
            }
        }
        
        return output
    }
}

//              0    1    2    3    4    5    6
let g = Graph(["U", "D", "A", "C", "I", "T", "Y"])
g.addEdge(from: 0, to: 1, weight: 3)
g.addEdge(from: 0, to: 2, weight: 4)
g.addEdge(from: 0, to: 3, weight: 6)
g.addEdge(from: 2, to: 4, weight: 7)
g.addEdge(from: 4, to: 3, weight: 4)
g.addEdge(from: 4, to: 6, weight: 4)
g.addEdge(from: 3, to: 5, weight: 5)
g.addEdge(from: 5, to: 6, weight: 5)

let s = g.matrix
    .map({
        $0.map({
            if let v = $0 {
                return String(v)
            }
            else {
                return "x"
            }
        }).joined(separator: ", ")
    }).joined(separator: "\n")

print(s)

g.shortestPath(from: 0, to: 0) == 0
g.shortestPath(from: 0, to: 1) == 3
g.shortestPath(from: 0, to: 3) == 6
g.shortestPath(from: 0, to: 4) == 10
g.shortestPath(from: 0, to: 6) == 14
