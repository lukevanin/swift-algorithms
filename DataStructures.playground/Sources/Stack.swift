//
//  Stack
//      Last In First Out (LIFO)
//      Push to head
//      Pop from head
//
import Foundation

extension Stack: CustomStringConvertible {
    public var description: String {
        return self.map({ String(describing: $0) }).joined(separator: ", ")
    }
}

extension Stack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        return Node.iterator(node: head)
    }
}

public class Stack<T> {
    fileprivate var head: Node<T>? = nil
    
    public init() {
    }
    
    public func peek() -> T? {
        return head?.value
    }
    
    public func push(value: T) {
        let node = Node(value: value, next: head)
        head = node
    }
    
    public func pop() -> T? {
        let node = head
        head = node?.next
        return node?.value
    }
}
