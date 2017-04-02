//
//  Bubble sort
//
import Foundation

func isSorted(_ values: [Int]) -> Bool {
    let count = values.count
    
    guard count > 1 else {
        return true
    }
    
    for i in 1 ..< count {
        guard values[i - 1] <= values[i] else {
            return false
        }
    }
    
    return true
}

func bubbleSort(_ values: [Int]) -> [Int] {
    let count = values.count
    
    guard count > 1 else {
        return values
    }

    var output = values
    var didSwap = false
    repeat {
        didSwap = false
        for i in 1 ..< count {
            let j = i - 1
            guard output[j] > output[i] else {
                continue
            }
            let t = values[i]
            output[i] = output[j]
            output[j] = t
            didSwap = true
        }
    } while didSwap == true
    
    return output
}

isSorted([])
isSorted([0])
isSorted([1, 1])
isSorted([0, 1])
!isSorted([1, 0])

isSorted(bubbleSort([]))
isSorted(bubbleSort([1]))
isSorted(bubbleSort([0, 1, 2, 3, 4]))
isSorted(bubbleSort([1, 0, 4, 3, 2]))
