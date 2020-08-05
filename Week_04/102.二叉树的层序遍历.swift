/*
 * @lc app=leetcode.cn id=102 lang=swift
 *
 * [102] 二叉树的层序遍历
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

    /*1、 dfs 前序遍历 递归
    时间复杂度:O(n)
    空间复杂度:O(n)
    */
    func levelOrder_1(_ root: TreeNode?) -> [[Int]] {

        if root == nil {
            return []
        }

        var result = [[Int]]()

        func dfs(_ level: Int, _ node: TreeNode?) {
            if node == nil {

                return 
            }

            if level == result.count {

                result.append([Int]())
            }

            result[level].append((node?.val)!)
            dfs(level + 1, node?.left)
            dfs(level + 1, node?.right)

        }

        dfs(0, root)

        return result
    }

    /*
    2、bfs  数组表示队列
    时间复杂度:O(n)
    空间复杂度:O(n)
    */
    func levelOrder(_ root: TreeNode?) -> [[Int]] {

        if root == nil {
            return []
        }

        var result = [[Int]]()
        var stack: [TreeNode] = [root!]

        while stack.count > 0 {
            
            var currenLayer = [Int]()

            for node in stack {

                stack.removeFirst() //先进先出
                currenLayer.append(node.val)

                if node.left != nil {
                    stack.append(node.left!)
                }

                if node.right != nil {
                    stack.append(node.right!)
                }
            }

            result.append(currenLayer)
        }

        return result
    }
}
// @lc code=end

