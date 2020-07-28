/*
 * @lc app=leetcode.cn id=206 lang=swift
 *
 * [206] 反转链表
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
class Solution {
    /*
    1、迭代  
    时间复杂度： O(n)
    空间复杂度： O(1)
    */
    func reverseList(_ head: ListNode?) -> ListNode? {

        if head == nil || head?.next == nil {

            return head
        }

        var pre: ListNode? = nil
        var middle = head

        while middle != nil {
            
            var next = middle?.next
            middle?.next = pre
            pre = middle

            middle = next
        }

        return pre
    }

    /*
    2、递归
    时间复杂度： O(n)
    空间复杂度： O(n)
    */
    func reverseList_2(_ head: ListNode?) -> ListNode? {

        if head == nil || head?.next == nil {

            return head
        }

        var p = reverseList(head?.next)
        head?.next?.next = head
        head?.next = nil

        return p
    }

    /*
    3、递归 方式2
    时间复杂度： O(n)
    空间复杂度： O(n)
    */
    func reverseList_3(_ head: ListNode?) -> ListNode? {

        if head == nil || head?.next == nil {

            return head
        }

        func reverse_List(_ head: ListNode?, _ newHead: ListNode?) -> ListNode? {
            if head == nil {
                return newHead
            }

            var next = head?.next
            head?.next = newHead
            return reverse_List(next, head)
        }

        return reverse_List(head, nil)
    }

}
// @lc code=end

