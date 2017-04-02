//
//  Queue
//      First In First Out (FIFO)
//      Enqueue at tail
//      Dequeue at head
//
import Foundation

extension Queue: CustomStringConvertible {
    public var description: String {
        return self.map({ String(describing: $0) }).joined(separator: ", ")
    }
}

extension Queue: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        return Node.iterator(node: head)
    }
}

public class Queue<T> {
    fileprivate var head: Node<T>? = nil
    fileprivate var tail: Node<T>? = nil
    
    public init() {
    }
    
    public func peek() -> T? {
        return head?.value
    }
    
    public func enqueue(value: T) {
        let node = Node(value: value)
        tail?.next = node
        tail = node
        if head == nil {
            head = node
        }
    }
    
    public func dequeue() -> T? {
        let node = head
        head = node?.next
        if head == nil {
            tail = nil
        }
        return node?.value
    }
}
