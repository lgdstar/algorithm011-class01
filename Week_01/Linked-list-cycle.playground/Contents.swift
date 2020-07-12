/*
* @lc app=leetcode.cn id=141 lang=swift
*
* [141] 环形链表
*/


import Cocoa

var str = "Hello, playground"

//Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

//1.双指针   时间复杂度:O(N)  空间复杂度O(1)
func hasCycle_1(_ head: ListNode?) -> Bool {
    
    if head == nil || head?.next == nil {
        
        return false
    }
    
    var low = head
    var fast = head?.next
    
    while fast?.val != low?.val {  //不能使用 ast != low 未实现该类的 ==方法
        
        if fast == nil || fast?.next == nil {
            
            return false
        }
        
        fast = fast?.next?.next
        low = low?.next
        
    }
    
    return true
}



/*
2. Hash表  使用Set表示Hash表，判断该结点是否已经存在于Set中来确定是否成环
 时间复杂度 O(n),空间复杂度 O(n)
 */
//ListNode 的延展，用于把结点放入 哈希表(Set)中
extension ListNode: Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
    hasher.combine(val)
    hasher.combine(Int(Date().timeIntervalSinceNow))
    }

    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs === rhs //指针是否引用同一实例
    }
 
}

func hasCycle(_ head: ListNode?) -> Bool {
    
    if head == nil || head?.next == nil {
        
        return false
    }
    
    var nodeSet = Set<ListNode>()
    var node = head
    
    while node != nil {
        
        if nodeSet.contains(node!) {
            
            return true
        } else {
            
            nodeSet.insert(node!)
        }
        
        node = node?.next
    }
    
    return false
}
