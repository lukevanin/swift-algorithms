// 
//  Shortest paths
//

import Foundation

class Graph {
    
    var edges: [[Int]]
    var memo: [Int]
    var parent: [Int]
    
    convenience init(count: Int) {
        let row = [Int](repeating: 0, count: count)
        let graph = [[Int]](repeating: row, count: count)
        self.init(edges: graph)
    }
    
    required init(edges: [[Int]]) {
        self.edges = edges
        self.memo = [Int](repeating: 0, count: edges.count)
        self.parent = [Int](repeating: 0, count: edges.count)
    }
    
    func shortestPath(_ s: Int, _ v: Int) -> [Int] {
        initialize()
        let length = delta(s, v)
        
        var n = v
        var output = [Int]()
        repeat {
            output.insert(n, at: 0)
            n = parent[n]
        } while n != s
        output.insert(s, at: 0)
        return output
    }
    
    private func initialize() {
        for i in 0 ..< edges.count {
            memo[i] = Int.max
            parent[i] = i
        }
    }
    
    private func delta(_ s: Int, _ v: Int) -> Int {
        
        if s == v {
            return 0
        }
        
        var output = memo[v]
        
        if output == Int.max {
        
            for u in 0 ..< edges.count {
                
                let e = edges[u]
                let w = e[v]
                
                if w == 0 {
                    // No path from u to v
                    continue
                }
                
                let result = delta(s, u) + w
                
                if result < output {
                    output = min(output, result)
                    parent[v] = u
                }
            }
            
            if output == Int.max {
                // No path from s to v
                output = 0
            }
            
            memo[v] = output
        }
        
        return output
    }
}

//let g0 = Graph(edges: [
//    [0, 3, 5, 0, 0],
//    [0, 0, 0, 3, 0],
//    [0, 0, 0, 0, 5],
//    [0, 0, 0, 0, 3],
//    [0, 0, 0, 0, 0]
//    ])
//
//g0.shortestPath(0, 4)

let g1 = Graph(count: 7)
g1.edges[0][1] = 2
g1.edges[0][2] = 6
g1.edges[0][4] = 6
g1.edges[1][2] = 3
g1.edges[2][3] = 5
g1.edges[2][6] = 11
g1.edges[4][3] = 7
g1.edges[3][5] = 3
g1.edges[5][6] = 2

g1.shortestPath(0, 6)



