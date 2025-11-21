//
//  AlarmQueue.swift
//  WakeUp
//
//  Created by a on 11/22/25.
//

extension AlarmEntity: Comparable {
    static func < (lhs: AlarmEntity, rhs: AlarmEntity) -> Bool {
        lhs.time < rhs.time
    }
}

struct AlarmQueue {
    private var heap: Heap<AlarmEntity>!
    
    init(sort: @escaping (AlarmEntity, AlarmEntity) -> Bool) {
        self.heap = Heap(sort: sort)
    }
    
    mutating func insert(_ alarm: AlarmEntity) {
        heap.insert(alarm)
    }
    
    mutating func delete() -> AlarmEntity? {
        heap.delete()
    }
    
    func peek() -> AlarmEntity? {
        heap.peek()
    }
}

struct Heap<T: Comparable> {
    
    private var elements: [T] = []
    private var sort: (T, T) -> Bool
    
    init(sort: @escaping (T, T) -> Bool) {
        self.sort = sort
    }
    
    func peek() -> T? {
        if elements.isEmpty {
            return nil
        }
        return self.elements[1]
    }
    
    mutating func insert(_ value: T) {
        if elements.isEmpty {
            elements.append(value)
        }
        elements.append(value)
        var currentIndex = elements.count - 1
        
        while currentIndex > 1 {
            let parentIndex = Int(currentIndex / 2)
            if sort(elements[currentIndex], elements[parentIndex]) {
                elements.swapAt(currentIndex, parentIndex)
                currentIndex = parentIndex
            } else {
                break
            }
        }
    }
    
    mutating func delete() -> T? {
        
        elements.swapAt(1, elements.count - 1)
        let maxElement = elements.removeLast()
        var currentIndex = 1
        
        while currentIndex <= (elements.count - 1) {
            let leftChildIndex = 2 * currentIndex
            let rightChildIndex = 2 * currentIndex + 1
            var maxIndex = currentIndex
            
            if leftChildIndex <= elements.count - 1 && sort(elements[leftChildIndex], elements[maxIndex]) {
                maxIndex = leftChildIndex
            }
            if rightChildIndex <= elements.count - 1 && sort(elements[rightChildIndex], elements[maxIndex]) {
                maxIndex = rightChildIndex
            }
            
            if currentIndex == maxIndex {
                break
            }
            
            elements.swapAt(maxIndex, currentIndex)
            currentIndex = maxIndex
        }
        
        return maxElement
    }
}
