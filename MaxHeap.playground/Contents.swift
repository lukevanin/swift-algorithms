//
//  Heap
//

import Foundation

class MaxHeap {
    
    var values = [Int]()
    
    //
    //  Delete value.
    //
    func extract() {
        
        // Get index of value in tree.
        guard let last = values.last else {
            return
        }
        
        // Swap last leaf with removed node.
        print("setting root to \(last)")
        
        values[0] = last
        values.removeLast()
        
        // Check if tree is empty
        if values.count == 0 {
            return
        }
        
        // Move value down the tree until it is lower than the parent.
        maxHeapify(at: 0)
    }
    
    //
    //
    //
    func maxHeapify(at index: Int) {
        let left = self.left(of: index)
        let right = self.right(of: index)
        var largest = index
        let size = values.count
        
        if left < size && values[left] > values[largest] {
            largest = left
        }
        
        if right < size && values[right] > values[largest] {
            largest = right
        }
        
        if largest != index {
            // Value at left or right is greater than node value.
            
            // Swap value at node with child value.
            let v = values[index]
            values[index] = values[largest]
            values[largest] = v
            
            // Recurse to child.
            maxHeapify(at: largest)
        }
    }
    
    //
    //  Insert value at next available location in the heap then heapify.
    //
    func insert(value: Int) {
        
        // Check if heap already contains value
        if values.index(of: value) != nil {
            return
        }
        
        // Insert at next available location
        let index = values.count
        values.append(value)
        
        // Heapify
        heapify(value: value, at: index)
    }
    
    //
    //
    //
    func heapify(value: Int, at index: Int) {
        if index == 0 {
            // Value is at root node.
            return
        }
        let p = parent(of: index)
        
        let v = values[p]
        
        if v > value {
            // Parent node is in heap order.
            return
        }

        values[p] = value
        values[index] = v
        heapify(value: value, at: p)
    }
    
    func left(of index: Int) -> Int {
        return (index << 1) + 1
    }
    
    func right(of index: Int) -> Int {
        return (index << 1) + 2
    }
    
    func parent(of index: Int) -> Int {
        return (index - 1) >> 1
    }
}

let heap = MaxHeap()

//       5
heap.insert(value: 5)
heap.values

//       5
//      /
//     1
heap.insert(value: 1)
heap.values

//       5
//      / \
//     1   3
heap.insert(value: 3)
heap.values

//       8
//      / \
//     5   3
//    /
//   1
heap.insert(value: 8)
heap.values

//       9
//      / \
//     8   3
//    / \
//   1   5
heap.insert(value: 9)
heap.values

//       8
//      / \
//     5   3
//    /
//   1
heap.extract()
heap.values

//       5
//      / \
//     1   3
heap.extract()
heap.values

