import Foundation

// Stack (Last In First Out)
let stack = Stack<String>()
stack.push(value: "A")
stack.push(value: "B")
stack.push(value: "C")
stack.pop() == "C"
stack.pop() == "B"
stack.pop() == "A"
stack.pop() == nil
stack.push(value: "D")
stack.push(value: "E")
stack.peek() == "E"
stack.pop() == "E"

// Queue (First In First Out)
let queue = Queue<String>()
queue.enqueue(value: "A")
queue.enqueue(value: "B")
queue.enqueue(value: "C")
queue.dequeue() == "A"
queue.dequeue() == "B"
queue.dequeue() == "C"
queue.dequeue() == nil
queue.enqueue(value: "D")
queue.enqueue(value: "E")
queue.peek() == "D"
queue.dequeue() == "D"



