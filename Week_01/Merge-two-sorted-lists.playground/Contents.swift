/*
* @lc app=leetcode.cn id=21 lang=swift
*
* [21] 合并两个有序链表
*/

import Cocoa

var str = "Hello, playground"

//链表类
class ListNode {
    var val: Int
    var next: ListNode?
    
    init() {
        self.val = 0
        self.next = nil
    }
    
    init(val: Int) {
        self.val = val
        self.next = nil
    }
    
    init(val: Int, next: ListNode) {
        self.val = val
        self.next = next
    }
}

/*
 1、递归
 两个链表头部值较小的一个节点与剩下元素的 merge 操作结果合并。

 算法
 我们直接将以上递归过程建模，同时需要考虑边界情况。
 如果 l1 或者 l2 一开始就是空链表 ，那么没有任何操作需要合并，所以我们只需要返回非空链表。否则，我们要判断 l1 和 l2 哪一个链表的头节点的值更小，然后递归地决定下一个添加到结果里的节点。如果两个链表有一个为空，递归结束。
 时间复杂度：O(n)
 */

func mergeTwoListsF(l1: ListNode?, l2: ListNode?) -> ListNode? {
    
    if l1 == nil {
        
        return l2
    } else if l2 == nil {
        
        return l1
    } else if (l1?.val)! < (l2?.val)! { //可变对象的属性对比需强转
        
        l1?.next = mergeTwoListsF(l1: l1?.next, l2: l2)
        return l1
    } else {
        l2?.next = mergeTwoListsF(l1: l1, l2: l2?.next)
        return l2
    }
}

var result = mergeTwoListsF(l1: ListNode(val: 1, next: ListNode(val: 2, next: ListNode(val: 4))), l2: ListNode(val: 1, next: ListNode(val: 3, next: ListNode(val: 4))))

//打印结果
while result != nil  {
    
    print((result?.val)!) //强转以防止警告
    result = result?.next
}

/* 2、迭代
 思路

 我们可以用迭代的方法来实现上述算法。当 l1 和 l2 都不是空链表时，判断 l1 和 l2 哪一个链表的头节点的值更小，将较小值的节点添加到结果里，当一个节点被添加到结果里之后，将对应链表中的节点向后移一位。

 算法

 首先，我们设定一个哨兵节点 prehead ，这可以在最后让我们比较容易地返回合并后的链表。我们维护一个 prev 指针，我们需要做的是调整它的 next 指针。然后，我们重复以下过程，直到 l1 或者 l2 指向了 null ：如果 l1 当前节点的值小于等于 l2 ，我们就把 l1 当前的节点接在 prev 节点的后面同时将 l1 指针往后移一位。否则，我们对 l2 做同样的操作。不管我们将哪一个元素接在了后面，我们都需要把 prev 向后移一位。

 在循环终止的时候， l1 和 l2 至多有一个是非空的。由于输入的两个链表都是有序的，所以不管哪个链表是非空的，它包含的所有元素都比前面已经合并链表中的所有元素都要大。这意味着我们只需要简单地将非空链表接在合并链表的后面，并返回合并链表即可。

 图解链接：https://leetcode-cn.com/problems/merge-two-sorted-lists/solution/he-bing-liang-ge-you-xu-lian-biao-by-leetcode-solu/
 时间复杂度：O(n)
 */

func mergeTwoListsS(l1: ListNode?, l2: ListNode?) -> ListNode? {
    
    let prehead: ListNode? = ListNode(val: -1)
    var l_1 = l1
    var l_2 = l2 //常量转变量
    
    var prev = prehead
    
    while l_1 != nil && l_2 != nil {
        if (l_1?.val)! <= (l_2?.val)! {
            prev?.next = l_1
            l_1 = l_1?.next
        } else {
            prev?.next = l_2
            l_2 = l_2?.next
        }
        
        prev = prev?.next
    }
    
    prev?.next = l_1 == nil ? l_2 : l_1
    
    return prehead?.next
}

result = mergeTwoListsF(l1: ListNode(val: 2, next: ListNode(val: 4, next: ListNode(val: 5))), l2: ListNode(val: 1, next: ListNode(val: 3, next: ListNode(val: 4))))

print("迭代")
//打印结果
while result != nil  {
    print((result?.val)!) //强转以防止警告
    result = result?.next
}
