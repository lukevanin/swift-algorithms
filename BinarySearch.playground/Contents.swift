//
//
//
import Foundation

func index(of value: Int, in values: [Int]) -> Int? {
    let count = values.count
    guard count > 0 else {
        return nil
    }
    
    var min = 0
    var max = count - 1
    var index: Int? = nil
    
    while true {
        let mid = min + ((max - min) / 2)
        let sample = values[mid]
        
        if value < sample {
            max = mid
        }
        else if value > sample {
            min = mid + 1
        }
        else {
            index = mid
            break
        }
        
        if ((min == max) && ((mid == min) || (mid == max))) || (min > max) {
            break
        }
    }
    
    return index
}

// Binary search
let listA = [1, 8, 9, 11, 13, 19, 29]

index(of: 1, in: listA) == 0
index(of: 8, in: listA) == 1
index(of: 9, in: listA) == 2
index(of: 11, in: listA) == 3
index(of: 13, in: listA) == 4
index(of: 19, in: listA) == 5
index(of: 29, in: listA) == 6
index(of: 34, in: listA) == nil
index(of: -12, in: listA) == nil
index(of: 0, in: [1]) == nil
index(of: 1, in: [0, 1]) == 1
index(of: 0, in: [0]) == 0
index(of: 1, in: [1, 1, 1]) != nil
index(of: 0, in: []) == nil
