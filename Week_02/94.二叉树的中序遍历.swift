/*
 * @lc app=leetcode.cn id=94 lang=swift
 *
 * [94] 二叉树的中序遍历
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
    func inorderTraversal_1(_ root: TreeNode?) -> [Int] {
        var result = [Int]()

        if root == nil {
            return result
        }

        result.append(contentsOf: inorderTraversal(root?.left))
        result.append((root?.val)!)
        result.append(contentsOf: inorderTraversal(root?.right))

        return result
    }

    /*
    2、栈， 使用数组实现栈
    时间复杂度：O(n)
    空间复杂度：O(n)
    */
    func inorderTraversal_2(_ root: TreeNode?) -> [Int] {
        var result = [Int]()

        if root == nil {
            return result
        }

        var stack = [TreeNode]() //使用数组模拟栈
        var node = root

        while node != nil || !stack.isEmpty {
            while node != nil {
                //添加全部左子树
                stack.append(node!)
                node = node?.left
            }

            node = stack.popLast() //移除数组最后一个元素并返回
            result.append((node?.val)!)
            node = node?.right
        }

        return result
    }

    /*
    3、颜色标记法 栈实现的另一种方式， 使用数组实现栈
    时间复杂度：O(n)
    空间复杂度：O(n)
    */
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var result = [Int]()

        if root == nil {
            return []
        }

        var stack: [Any?] = [root] //使用数组模拟栈，数组元素任意类型

        while !stack.isEmpty {
           let node = stack.removeLast() //移除并返回最后一项

           if let node = node as? TreeNode {
               //把结点更换为 一个二叉树样式重新存入，按排序顺序相反顺序存入
               stack.append(node.right)
               stack.append(node.val)
               stack.append(node.left)
           } else if let val = node as? Int {

               result.append(val)
           }
        }

        return result
    }

}
// @lc code=end

