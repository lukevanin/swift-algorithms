//
//  Shortest paths
//

import Foundation

struct Edge {
    let v: Int
    let w: Int
}

class Graph {
    
    // Store edge list (|V|·|E|) space complexity
    var edges: [[Edge]]
    
    convenience init(count: Int) {
        let graph = [[Edge]](repeating: [], count: count)
        self.init(edges: graph)
    }
    
    required init(edges: [[Edge]]) {
        self.edges = edges
    }
    
    func edge(_ from: Int, _ to: Int, _ weight: Int) {
        guard weight > 0 else {
            fatalError("Cannot insert zero weight edge")
        }
        self.edges[from].append(Edge(v: to, w: weight))
    }
    
    func shortestPath(_ s: Int, _ v: Int) -> Int {

        // Memoize the shortest paths from s for each node.
        var memo = [Int](repeating: Int.max, count: edges.count)
        
        // Initialize known distance s -> s = 0.
        memo[s] = 0;

        // Start from node s.
        var k = s
        
        // Loop until target node is reached.
        // FIXME: This will enter an infinite loop if there is no path from s -> v
        while k != v {
            
            // c = known length of path up to node k, calculated from previous steps.
            var j = k
            let c = memo[k]
            
            // Current shortest path from k to all nodes from k
            var shortest = Int.max

            // Check distance of each outgoing edge from node k.
            for e in edges[k] {

                let u = e.v
                let w = e.w
                
                // Calculate distance from k to u.
                // If distance is shorter than known distance to u, then store distance and visit u next.
                memo[u] = min(memo[u], c + w)
                if memo[u] < shortest {
                    shortest = memo[u]
                    j = u
                }
            }
            
            if j == k {
                // No path from s to v
                break
            }
            
            k = j
        }
        
        return memo[v]
    }
}

let g1 = Graph(count: 7)
g1.edge(0, 1, 2)
g1.edge(0, 2, 6)
g1.edge(0, 4, 6)
g1.edge(1, 2, 3)
g1.edge(2, 3, 5)
g1.edge(2, 6, 11)
g1.edge(3, 5, 3)
g1.edge(4, 3, 7)
g1.edge(5, 6, 2)

g1.shortestPath(1, 6)
g1.shortestPath(6, 1)
//g1.shortestPath(4, 6) == (7 + 3 + 2)



