//
//  Every number after the first two is the sum of the two preceding ones
//      0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ...
//
import Foundation

var lookup = [UInt64: UInt64]()

func fibonacci(_ p: UInt64) -> UInt64 {
    if p == 0 || p == 1 {
        return UInt64(p)
    }
    
    var answer = lookup[p]
    if answer == nil {
        answer = fibonacci(p - 1) + fibonacci(p - 2)
        lookup[p] = answer
    }
    return answer!
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
fibonacci(34) == 5702887
fibonacci(55) == 139583862445
fibonacci(89) == 1779979416004714189
//fibonacci(144) == 555565404224292694404015791808 // Number too large for UInt64

