/*
 * @lc app=leetcode.cn id=212 lang=swift
 *
 * [212] 单词搜索 II
 */

// @lc code=start

class TrieNode {
    var links = [Character: TrieNode]()
    var isEnd = false
}

class TrieNode1 {
    var links = [Character: TrieNode1]()
    var word: String = "" //使用字符串作为结尾
}

class Solution {

    /* 
    1、 字典树  结尾标识使用bool类型
    时间复杂度： O(M * 4 * (3^(L - 1)))  其中M为二维网格中的单元格数，L是单词最大长度
    单词的最大长度是 L，从一个单元格开始，最初我们最多可以探索 4 个方向。
    假设每个方向都是有效的（即最坏情况），在接下来的探索中，我们最多有 3 个相邻的单元（不包括我们来的单元）要探索。
    因此，在回溯探索期间，我们最多遍历 4 * (3^(L - 1))个单元格。

    空间复杂度： O(N) N是字典中的字母总数
    算法消耗的主要空间是我们构建的 Trie 数据结构。
    在最坏的情况下，如果单词之间没有前缀重叠，则 Trie 将拥有与所有单词的字母一样多的节点。
    也可以选择在 Trie 中保留单词的副本。因此，我们可能需要 2N 的空间用于 Trie。
    */
    func findWords_1(_ board: [[Character]], _ words: [String]) -> [String] {

        guard board.count > 0, board[0].count > 0, words.count > 0 else {
            
            return []
        }

        //四联通
        let dx = [-1, 1, 0, 0], dy = [0, 0, -1, 1]
        var result = Set<String>()

        //创建 trieNode，把words数据插入
        let root = TrieNode()
        for word in words {
            var node = root
            for char in word {
                if let next = node.links[char] {
                    
                    node = next
                } else {
                    let next = TrieNode()
                    node.links[char] = next
                    node = next //切换下一结点
                }

            }
            node.isEnd = true
        }

        var board = board
        let m = board.count, n = board[0].count

        //board进行dfs 
        func dfs(_ row: Int, _ colm: Int, _ currWord: String, _ currNode: TrieNode){
            let currWord = currWord + String(board[row][colm])
            let currNode = currNode.links[board[row][colm]]!
            if currNode.isEnd == true {

                result.insert(currWord)
            }

            let temp = board[row][colm]
            board[row][colm] = "@"  //占位标识，用于标识已使用

            for i in 0..<4 {
                let x = dx[i] + row , y = dy[i] + colm 

                if x >= 0, x < m, y >= 0, y < n , board[x][y] != "@",
                 currNode.links[board[x][y]] != nil {

                     dfs(x, y, currWord, currNode)
                 }

            }

            board[row][colm] = temp // 回溯
        }


        for i in 0..<m {
            for j in 0..<n {
                
                if root.links[board[i][j]] != nil {

                    dfs(i, j, "", root)
                }
            }
        }

        return Array(result)
    }

    /*
    2、字典树trie ,以字符串为结尾标识
    */
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {

        guard board.count > 0, board[0].count > 0, words.count > 0 else {
            
            return []
        }

        let dx = [-1, 1, 0, 0], dy = [0, 0, -1, 1]
        var result = Set<String>()

        //创建 trieNode，把words数据插入
        let root = TrieNode1()
        for word in words {
            var node = root
            for char in word {
                if let next = node.links[char] {
                    
                    node = next
                } else {
                    let next = TrieNode1()
                    node.links[char] = next
                    node = next
                }

            }
            node.word = word
        }

        var board = board
        let m = board.count, n = board[0].count

        //board进行dfs 
        func dfs(_ row: Int, _ colm: Int,  _ currNode: TrieNode1){
            let currNode = currNode.links[board[row][colm]]!
            if currNode.word != "" {

                result.insert(currNode.word)
                currNode.word = "" //去重，单词已匹配
            }

            let temp = board[row][colm]
            board[row][colm] = "@"  //占位标识，用于标识已使用

            //四联通 上下左右
            for i in 0..<4 {
                let x = dx[i] + row , y = dy[i] + colm 

                if x >= 0, x < m, y >= 0, y < n , board[x][y] != "@",
                 currNode.links[board[x][y]] != nil {

                     dfs(x, y, currNode)
                 }

            }

            board[row][colm] = temp // 回溯
        }


        for i in 0..<m {
            for j in 0..<n {
                
                if root.links[board[i][j]] != nil {

                    dfs(i, j, root)
                }
            }
        }

        return Array(result)
    }
}
// @lc code=end

