//
//  Knapsack Problem
//      Knapsack of size (S)
//      N items where:
//          Size Si
//          Value Vi
//      O(nS) Pseudo-polynomial
//      Maximize sim of values for subset of items of total size ≦ S
//

import Foundation

struct Item {
    let weight: Int
    let value: Int
}

func fit(items: [Item], maxWeight: Int) -> Int {
    
    // Table of maximum values corresponding to each weight.
    // Initialize weights to 0.
    var lookup = [Int](repeating: 0, count: maxWeight + 1)

    for item in items {
        
        for i in item.weight ... maxWeight {
            
            // Maximize value for item weight.
            if item.value > lookup[i] {
                lookup[i] = item.value
            }
            else {
            
                // Maximize the value for the remaining capacity.
                let remaining = i - item.weight
                
                if remaining > 0 {
                    lookup[i] = max(lookup[i], item.value + lookup[remaining])
                }
            }
        }
        
    }
    
    // Return max value
    var output = lookup[maxWeight]
    for i in lookup {
        output = max(output, i)
    }
    return output
}

let items = [
    Item(weight: 2, value: 6),
    Item(weight: 5, value: 9),
    Item(weight: 4, value: 5)
]

fit(items: items, maxWeight: 6)
