/*
 * @lc app=leetcode.cn id=144 lang=swift
 *
 * [144] 二叉树的前序遍历
 */

// @lc code=start
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
class Solution {
    /*
    1、递归
    时间复杂度：O(n),遍历所有节点
    空间复杂度：最坏情况下(链表形式)需要空间O(n)，平均情况为O(logn)
    */
    func preorderTraversal_1(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        
        var result = [Int]()

        result.append((root?.val)!)
        result.append(contentsOf: preorderTraversal(root?.left))
        result.append(contentsOf: preorderTraversal(root?.right))

        return result
    }
    /*
    2、栈 使用数组实现栈
    时间复杂度：O(n)
    空间复杂度：O(n)
    */
    func preorderTraversal_2(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        
        var result = [Int]()
        var stack = [TreeNode]()
        var node = root

        while node != nil || !stack.isEmpty {
            while node != nil {
                result.append((node?.val)!) //首先添加所有根节点
                stack.append(node!)
                node = node?.left
            }

            node = stack.popLast()
            node = node?.right
        }

        return result
    }

    //前序遍历的简化版本
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        
        var result = [Int]()
        var stack: Array<TreeNode> = [root!]

        while !stack.isEmpty {

            let node = stack.removeLast()
            result.append(node.val)
            if node.right != nil {
                stack.append(node.right!)
            }

            if node.left != nil {
                stack.append(node.left!)
            }
        }

        return result
    }

    
    /*
    3、颜色标记法 (栈的另一种实现方式)
    时间复杂度：O(n)
    空间复杂度：O(n)
    */
    func preorderTraversal_3(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        
        var result = [Int]()
        var stack: [Any?] = [root]

        while !stack.isEmpty {
           let node = stack.removeLast()

           if let node = node as? TreeNode {
               //把结点更换为 一个二叉树样式重新存入，按排序顺序相反顺序存入
               stack.append(node.right)
               stack.append(node.left)
               stack.append(node.val)

           } else if let val = node as? Int {
               
               result.append(val)
           }

        }

        return result
    }

}
// @lc code=end

