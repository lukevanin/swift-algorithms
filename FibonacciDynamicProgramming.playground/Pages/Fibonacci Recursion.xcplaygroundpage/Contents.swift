//
//
//

import Foundation

var memo = [Int: Int64]()

func fib(_ n: Int) -> Int64 {
    
    let f: Int64
    
    if let g = memo[n] {
        f = g
    }
    else {
        if n <= 2 {
            f = 1
        }
        else {
            f = fib(n - 1) + fib(n - 2)
        }
        memo[n] = f
    }
    return f
}

fib(30)
