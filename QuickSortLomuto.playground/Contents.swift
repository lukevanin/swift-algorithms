//: Playground - noun: a place where people can play

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

func quicksort(_ values: [Int]) -> [Int] {
    let count = values.count
    
    guard count > 1 else {
        return values
    }
    
    var output = values
    quicksortSegment(values: &output, min: 0, max: count - 1)
    return output
}

func quicksortSegment(values: inout [Int], min: Int, max: Int) {
    
    guard min < max else {
        // Single element is already sorted
        return
    }
    
    print("")
    print("sorting \(min) ... \(max)")
    
    let p = partition(values: &values, min: min, max: max)
    quicksortSegment(values: &values, min: min, max: p - 1)
    quicksortSegment(values: &values, min: p + 1, max: max)
}

func partition(values: inout [Int], min: Int, max: Int) -> Int {
    let pivot = values[max]
    var i = min - 1
    for j in min ..< max {
        if values[j] <= pivot {
            i += 1
            swap(values: &values, at: i, with: j)
        }
    }
    swap(values: &values, at: i + 1, with: max)
    return i + 1
}

func swap(values: inout [Int], at a: Int, with b: Int) {
    guard a != b else {
        return
    }
    let t = values[a]
    values[a] = values[b]
    values[b] = t
    print("swap \(a) with \(b)")
    print(values)
}

isSorted([])
isSorted([0])
isSorted([1, 1])
isSorted([0, 1])
!isSorted([1, 0])

//isSorted(quicksort([]))
//isSorted(quicksort([1]))
//isSorted(quicksort([0, 1, 2, 3, 4]))
isSorted(quicksort([1, 0, 4, 3, 2]))

