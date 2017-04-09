//
//  Knapsack
//

import Foundation

struct Item {
    let weight: Int
    let value: Int
}

class Knapsack {
    let items: [Item]
    let maxWeight: Int
    
    var values = [Int]()
    
    init(maxWeight: Int, items: [Item]) {
        self.items = items
        self.maxWeight = maxWeight
    }
    
    func find() -> Int {
        values = [Int](repeating: 0, count: maxWeight + 1)
        
        for i in 0 ..< items.count {
            values[i] = dp(i: i, remaining: maxWeight)
        }
        
        return values[maxWeight]
    }
    
    func dp(i: Int, remaining: Int) -> Int {
        let item = items[i]
        let a = dp(i: i + 1, remaining: remaining)
        let b = dp(i: i + 1, remaining: remaining - item.weight) + item.value
        return max(a, b)
    }
}

let k = Knapsack(
    maxWeight: 6,
    items: [
        Item(weight: 2, value: 6),
        Item(weight: 5, value: 9),
        Item(weight: 4, value: 5)
    ]
)
k.find()

