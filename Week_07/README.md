## 学习笔记

#### 算法相关

##### 1、单词搜索 ii (leetcode 212) 题目使用 Trie 树方式实现的时间复杂度

* 最坏情况下，该算法循环遍历二维网格中的所有单元，设置二维网格中的单元格数为M。 此时需计算每个启动单元所需的最大步骤数
* 假设单词的最大长度为L，从第一个开始进行 dfs 的单元格开始，最初可以探索4个方向。 对后续的子单元格节点来说，最多有3个相邻的单元(除去了来的父节点单元)，此时考虑最坏情况，即3个方向。因此在 dfs 下探至最后一个字符时，此时最多遍历 4 * (3 ^ (L - 1)) 个单元格
* 单元格数与每个启动单元所需的最大步骤书相乘得时间复杂度为 O(M(4 * (3 ^ (L - 1))))

##### 2、并查集 Swift实现

```swift
//并查集 标准代码
class UnionFind {

    var count = 0
    var parent = [Int]()

    init(_ n: Int) {
        count = n
        parent = [Int](repeating: 0, count: n)
        for i in 0..<n {
            parent[i] = i
        }
    }

    //找到元素x所在集合的代表
    public func find(_ p: Int) -> Int {
        var root = p
        while root != parent[root] {
            root = parent[root]
        }

        var r = p
        if parent[r] == root {
          //路径已经压缩完成
            return root
        }
      //路径压缩：全部子节点指向领头元素
        while parent[r] != r {
            let x = r
            r = parent[r]
            parent[x] = root 
        }
		
        return root
    }

    public func union(_ p: Int, _ q: Int) {

        var rootP = find(p)
        var rootQ = find(q)
        if rootP == rootQ {
            return
        }
        parent[rootP] = rootQ
        count -= 1
    }
}
```



另一种优化方式:  union方法优化-深度小的往深度大的集合上合并，这样可以避免集合深度过大，find 的时候层级太多影响效率

```swift
//并查集 标准代码
class UnionFind {

    var count = 0
    var parent = [Int]()
    var rank = [Int]()

    init(_ n: Int) {
        count = n
        parent = [Int](repeating: 0, count: n)
        rank = [Int](repeating: 0, count: n)
        for i in 0..<n {
            parent[i] = i
        }
    }

    //找到元素x所在集合的代表
    public func find(_ p: Int) -> Int {
        var root = p
        while root != parent[root] {
            root = parent[root]
        }
        return root
    }

    public func union(_ p: Int, _ q: Int) {

        var rootP = find(p)
        var rootQ = find(q)
        if rootP == rootQ {
            return
        }
      
        // 优雅的写法：深度小的往深度大的集合上合并，这样可以避免集合深度过大，find 的时候层级太多影响效率
        if rank[rootP] > rank[rootQ] {
            parent[rootQ] = rootP
        } else if rank[rootP] < rank[rootQ] {
            parent[rootP] = rootQ
        } else {
            parent[rootQ] = rootP
            // 深度需要 + 1
            rank[rootP] += 1
        }
        count -= 1
    }
}
```



----

#### Swift相关

1、多个变量或常量初始化，可使用 , 隔开

```swift
var num = 9, name = "lgd", habit = [Int]()
let num = 9, name = "lgd"
```



2、交换两个数据，可以不使用中间变量转换

```swift
var num1 = 9, num2 = 8
(num1, num2) = (num2, num1)
```

