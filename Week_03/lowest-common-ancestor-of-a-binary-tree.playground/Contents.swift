/*
* @lc app=leetcode.cn id=236 lang=swift
*
* [236] 二叉树最近公共祖先
*/


import Cocoa

var str = "Hello, playground"


//Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

//1、递归
func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    
    //1. recursion terminator
    if root == nil
        || root?.val == p?.val
        || root?.val == q?.val {
        
        return root
    }
    
    //3. drill down
    let left = lowestCommonAncestor(root?.left, p, q)
    let right = lowestCommonAncestor(root?.right, p, q)
    
    //4. reverse
    
    //2.process logic
    return (left == nil) ? right : (right == nil) ? left : root;
}

//2、使用哈希表存储父节点
func lowestCommonAncestor_2(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    
    var fatherDic = [Int: TreeNode]()
    var roadDic = [Int: Bool]()
    
    //递归方法 遍历二叉树，在哈希表中存入父类节点
    func dfs(r: TreeNode?) {
        
        if r == nil {
            return
        }
        
        if r?.left != nil {
            fatherDic[(r?.left?.val)!] = r
            
            dfs(r: r?.left)
        }
        
        if r?.right != nil {
            fatherDic[(r?.right?.val)!] = r
            
            dfs(r: r?.right)
        }
    }
    
    dfs(r: root)
    
    var pNode = p
    var qNode = q
    
    while pNode != nil {
        
        roadDic[(pNode?.val)!] = true
        pNode = fatherDic[(pNode?.val)!]
    }
    
    while qNode != nil {
        if roadDic[(qNode?.val)!] == true {
            
            return qNode
        }
        
        qNode = fatherDic[(qNode?.val)!]
    }
    
    return nil
}

//3、使用不同方式Hash表存储，使用迭代方式存入父类结点
extension TreeNode :Hashable, Equatable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs === rhs //指针引用的是否为同一个实例
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(Int(Date().timeIntervalSinceNow))
    }
}

func lowestCommonAncestor_2A(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    
    var stack = [root]
    var parent = [TreeNode?: Any]()
    parent[root] = NSNull()  //添加根节点对应空值对象
    
    //使用迭代方式存入父类结点
    while parent.keys.contains(p) == false
        || parent.keys.contains(q) == false {
            
            let node = stack.popLast()!
            if node?.left != nil {
                parent[node?.left] = node
                stack.append(node?.left)
            }
            
            if node?.right != nil {
                parent[node?.right] = node
                stack.append(node?.right)
            }
    }
    
    var ancestors = Set<TreeNode?>()
    var firstNode = p
    var secondeNode = q
    while firstNode != nil { //添加 p节点的所有父类
        ancestors.insert(firstNode)
        firstNode = parent[firstNode] as? TreeNode
    }
    
    while ancestors.contains(secondeNode) == false {
        
        secondeNode = parent[secondeNode] as? TreeNode
    }
    
    return secondeNode
}

/*
 时间复杂度：O(N)，其中 N 是二叉树的节点数。二叉树的所有节点有且只会被访问一次，因此时间复杂度为 O(N)。

 空间复杂度：O(N) ，其中 N 是二叉树的节点数。递归调用的栈深度取决于二叉树的高度，二叉树最坏情况下为一条链，此时高度为 N，因此空间复杂度为 O(N)。
 */
