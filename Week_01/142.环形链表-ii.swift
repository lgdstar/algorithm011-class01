/*
 * @lc app=leetcode.cn id=142 lang=swift
 *
 * [142] 环形链表 II
 */

// @lc code=start
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */

extension ListNode: Hashable, Equatable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(Int(Date().timeIntervalSinceNow))
    }
    
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs === rhs //指针引用的是否为同一个实例
    }
    
}

class Solution {

    /*1、双指针
    时间复杂度O(n)
    空间复杂度O(1)
    
    解法逻辑参考：
    https://leetcode-cn.com/problems/linked-list-cycle-ii/solution/linked-list-cycle-ii-kuai-man-zhi-zhen-shuang-zhi-/
    */
    func detectCycle_1(_ head: ListNode?) -> ListNode? {
        if head == nil  {

            return head
        }

        var fast = head
        var slow = head

        while true {

            if fast == nil {

                return nil
            }
            
            fast = fast?.next?.next
            slow = slow?.next

            if fast === slow {

                break
            }
        }

        fast = head
        while fast !== slow {
            
            fast = fast?.next
            slow = slow?.next
        }

        return fast
    }

    /*
    2、Hash表存储
    时间复杂度：O(n)
    空间复杂度：O(n)
    */
    func detectCycle(_ head: ListNode?) -> ListNode? {
        if head == nil  {

            return head
        }

        var nodeSet = Set<ListNode>()
        var node = head

        while node != nil {

            if nodeSet.contains(node!) == true {

                return node
            }

            nodeSet.insert(node!)
            node = node?.next
        }

        return nil
    }
}
// @lc code=end

