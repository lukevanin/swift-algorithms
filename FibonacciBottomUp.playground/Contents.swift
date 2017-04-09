//: Playground - noun: a place where people can play

import Foundation

func fibonacci(_ n: Int) -> Int64 {
    var fib = [Int64](repeating: 0, count: n + 1)
    
    for k in 1 ... n {
        let f: Int64
        
        if k <= 2 {
            f = 1
        }
        else {
            f = fib[k - 1] + fib[k - 2]
        }
        
        fib[k] = f
    }
    
    return fib[n]
}

let f1 = fibonacci(11)
let f2 = fibonacci(Int(f1))