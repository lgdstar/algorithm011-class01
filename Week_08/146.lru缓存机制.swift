/*
 * @lc app=leetcode.cn id=146 lang=swift
 *
 * [146] LRU缓存机制
 */

// @lc code=start

//双向链表
class DLinkedNode {

    var val: Int
    var next: DLinkedNode?
    var pre: DLinkedNode?
    var key: Int?

    
    init(val: Int, key: Int? = nil, next: DLinkedNode? = nil, pre: DLinkedNode? = nil) {
        self.val = val
        self.key = key
        self.next = next
        self.pre = pre
    }
}

class LRUCache {

    var capacity = 0, count = 0
    let first = DLinkedNode(val: -1), last = DLinkedNode(val: -1)

    var hash = 
    Dictionary<Int, DLinkedNode>()
    

    init(_ capacity: Int) {

        self.capacity = capacity
        first.next = last
        first.pre = nil

        last.pre = first
        last.next = nil
    }

    func moveToHead(node: DLinkedNode) {
        let pre = node.pre
        let next = node.next

        pre?.next = next
        next?.pre = pre

        node.next = first.next
        first.next?.pre = node
        first.next = node
        node.pre = first
    }

    func removeLastNode() {
        let node = last.pre
        node?.pre?.next = last
        last.pre = node?.pre
        count -= 1
        hash[node!.key!] = nil
    }
    
    func addNewNode(key: Int, node: DLinkedNode) {
        moveToHead(node: node)
        count += 1
        hash[key] = node
    }

    
    func get(_ key: Int) -> Int {

        let node = hash[key]

        if let n = node {
            moveToHead(node: n)
            return n.val
        } else {
             
             return -1
        }
    }
    
    func put(_ key: Int, _ value: Int) {

        let node = hash[key]
         if let n = node {
            n.val = value
            moveToHead(node: n)
        } else {

            let newNode = DLinkedNode(val: value, key: key)

            if count >= capacity {
                removeLastNode()
                addNewNode(key: key, node: newNode)
            } else {
                addNewNode(key: key, node: newNode)
            }
             
        }

    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */
// @lc code=end

