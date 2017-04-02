import Foundation

class Node<T> {
    var value: T
    var next: Node<T>?
    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
    
    func iterator() -> AnyIterator<T> {
        var current: Node<T>? = self
        return AnyIterator {
            defer {
                current = current?.next
            }
            return current?.value
        }
    }
    
    static func iterator(node: Node?) -> AnyIterator<T> {
        return node?.iterator() ?? AnyIterator({ return nil })
    }
}
