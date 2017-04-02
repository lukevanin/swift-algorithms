//
//
//
import Foundation

// Fibonacci with recursion
func fibonacci(_ p: Int) -> Int {
    if p == 0 || p == 1 {
        return p
    }
    return fibonacci(p - 1) + fibonacci(p - 2)
}

fibonacci(0) == 0
fibonacci(1) == 1
fibonacci(2) == 1
fibonacci(3) == 2
fibonacci(4) == 3
fibonacci(5) == 5
fibonacci(6) == 8
fibonacci(7) == 13
fibonacci(8) == 21
fibonacci(9) == 34
fibonacci(10) == 55
fibonacci(11) == 89
fibonacci(12) == 144

fibonacci(0) == 0
fibonacci(1) == 1
fibonacci(1) == 1
fibonacci(2) == 1
fibonacci(3) == 2
fibonacci(5) == 5
fibonacci(8) == 21
fibonacci(13) == 233
fibonacci(21) == 10946


