/*
 * @lc app=leetcode.cn id=51 lang=swift
 *
 * [51] N皇后
 */

// @lc code=start
class Solution {

    /* 1、递归
    时间复杂度： O(2)
    */
    func solveNQueens_1(_ n: Int) -> [[String]] {

        var result = [[Int]]()

        func dfs(_ queens: [Int], _ xy_dif: [Int], _ xy_sum: [Int]) {

            let p = queens.count
            if p == n {
                
                result.append(queens)
                return
            }

            for q in 0..<n {

                if !queens.contains(q), !xy_dif.contains(p + q), !xy_sum.contains(p - q + n) {

                    dfs(queens + [q], xy_dif + [p + q], xy_sum + [p - q + n])

                }
            }
        }

        dfs([],[],[])

        //输出结果
        func generate_result(_ k: Int) -> [[String]] {

            var strResult = [[String]]()

            for res in result {

                var board = [String]()
                for i in res {
                    
                    var str = String()
                    for item in 0..<k {
                        if item == i {

                            str += "Q"
                        } else {
                            str += "."
                        }
                    }

                    board.append(str)
                }

                strResult.append(board)
            }

            return strResult
        }

        return generate_result(n)
    }

    /*2、回溯 使用Set 
         时间复杂度：O(N!). 放置第 1 个皇后有 N 种可能的方法，放置两个皇后的方法不超过 N (N - 2) ，放置 3 个皇后的方法不超过 N(N - 2)(N - 4) ，以此类推。总体上，时间复杂度为 O(N!) .
      空间复杂度：O(N) . 需要保存对角线和行的信息
      */
    func solveNQueens_2(_ n: Int) -> [[String]] {
        if n < 1 {
            return []
        }

        var result = [[Int]]()
        var cols = Set<Int>(), pie = Set<Int>(), na = Set<Int>()

        func dfs(_ queens: [Int]) {
            let row = queens.count
            if row == n {
                result.append(queens)
                return
            }

            for col in 0..<n {
                if cols.contains(col)
                || pie.contains(col + row)
                || na.contains(row - col) {
                    continue
                }

                cols.insert(col)
                pie.insert(col + row)
                na.insert(row - col)
                dfs(queens + [col])
                //回溯
                cols.remove(col)
                pie.remove(col + row)
                na.remove(row - col)
            }
        }

        dfs([])

        //输出结果
        func generate_result(_ k: Int) -> [[String]] {

            var strResult = [[String]]()

            for res in result {
                var board = [String]()
                for i in res {
                    
                    var str = String()
                    for j in 0..<k {
                        if i == j {
                            str += "Q"
                        } else {
                            str += "."
                        }
                    }

                    board.append(str)
                }
                strResult.append(board)
            }
            return strResult
        }

        return generate_result(n)
    }

    /*
    3、回溯
    使用数组索引标识 列、主对角线和副对角线，数组存值1表示占用，0表示未占用
    或者使用 [Bool] 数组，用true表示已占用，false表示未占用
    */
    var resultQueens = [[String]]()
    var Q = Character("Q"), Dot = Character(".") 

    func solveNQueens_3(_ n: Int) -> [[String]] {

        var cols = [Int](repeating: 0 , count: n)
        var diag1 = [Int](repeating: 0, count: 2 * n - 1) 
        //使用 2n 可在dfs时，对 diag2 的 row - col + n ，减少耗时增加耗费空间
        var diag2 = [Int](repeating: 0, count: 2 * n - 1) 
        var queens = [Int]()

        queenDfs(&cols, &diag1, &diag2, &queens, n)
        return resultQueens
    }

    private func queenDfs(_ cols: inout [Int], 
    _ diag1: inout [Int], 
    _ diag2: inout [Int],
    _ queens: inout [Int],
    _ n: Int) {
        let row = queens.count
        if row == n {
            creatQueenAns(queens)
            return
        }

        for col in 0..<n {
            
            if cols[col] + diag1[col + row] + diag2[row - col + n - 1] == 0 {
                queens.append(col)
                cols[col] = 1
                diag1[col + row] = 1
                diag2[row - col + n - 1] = 1
                queenDfs(&cols, &diag1, &diag2, &queens, n)
                //回溯
                queens.removeLast()
                cols[col] = 0
                diag1[col + row] = 0
                diag2[row - col + n - 1] = 0
            }
        }
    }

    private func creatQueenAns(_ queens: [Int]) {
        var chars = [Character](repeating: Dot, count: queens.count)
        var sub = [String]()

        for index in queens {
            chars[index] = Q 
            sub.append(String(chars))
            chars[index] = Dot
        }

        resultQueens.append(sub)
    }

    /*  与方法3 并无时间上优化
    使用一个数组，n + 2 * n - 1 + 2 * n - 1 = 5 * n - 2 长度
    索引值：
    col 0...(n - 1); 
    diag1 n...(3 * n - 2); + row + col
    diag2 (3 * n - 1)...(5 * n - 3); + row - col + n - 1
    */
    func solveNQueens_3_1(_ n: Int) -> [[String]] {

        var flag = [Int](repeating: 0, count: 5 * n - 2) 
        var queens = [Int]()

        queenDfs_1(&flag, &queens, n)
        return resultQueens
    }

    private func queenDfs_1(_ flag: inout [Int], 
    _ queens: inout [Int],
    _ n: Int) {
        let row = queens.count
        if row == n {
            creatQueenAns(queens)
            return
        }

        for col in 0..<n {
            
            if flag[col] + flag[col + row + n] + flag[row - col + 4 * n - 2] == 0 {
                queens.append(col)
                flag[col] = 1
                flag[col + row + n] = 1
                flag[row - col + 4 * n - 2] = 1
                queenDfs_1(&flag, &queens, n)
                //回溯
                queens.removeLast()
                flag[col] = 0
                flag[col + row + n] = 0
                flag[row - col + 4 * n - 2] = 0
            }
        }
    }

    //4、位运算 使用Int的二进制位表示列、撇、捺 不超过32位(n <= 32)
    func solveNQueens(_ n: Int) -> [[String]] {
        if n < 1 {
            return []
        }

        var queens = [Int](repeating: 0, count: n)

        bitDfs(0,0,0,0,n,&queens)
        return resultQueens
    }

    /*
    位运算 值样式
    [4,1,8,2]
    [0100,
     0001,
     1000,
     0010]
    */
    private func bitDfs(_ row: Int, 
    _ col: Int, 
    _ diag1: Int, 
    _ diag2: Int, 
    _ n: Int, 
    _ queens: inout [Int]) {

        if row == n {

            creatQueenAnsBit(queens)
            return
        }

        /* 得到当前的空位，赋值为1显示
        (col | diag1 | diag2) 所有皇后已占据位置，取反 ~ 表示可放置的空位(当前赋为1)
        ((1 << n) - 1) n位1
        &之后，清除n位之前的所有多余位
        */
        var bits = (~(col | diag1 | diag2)) & ((1 << n) - 1)

        while bits != 0 {
            var p = bits & -bits //取到最低位的1。(负数以其正值的补码存在，补码为反码+1)
            queens[row] = p
            bits = bits & (bits - 1) //清零最低位的1，表示皇后已占位
            
            bitDfs(row + 1, col | p , (diag1 | p) << 1, (diag2 | p) >> 1, n, &queens)
            //不需要reverse col,diag1,diag2 的状态
        }
    }

    private func creatQueenAnsBit(_ queens: [Int]) {

        var chars = [Character](repeating: Dot, count: queens.count)
        var sub = [String]()

        for i in 0..<queens.count {
            var count = 0
            var bitIndex = queens[i]
            while bitIndex != 0 {
                bitIndex >>= 1 // binIdx = binIdx >> 1 位右移1位
                count += 1
            }

            //组装字符串
            chars[queens.count - count] = Q 
            sub.append(String(chars))
            chars[queens.count - count] = Dot

            /* //组装方式2
            var str = String()
            for j in 0..<queens.count {
                
                if j == queens.count - count {
                    str.append("Q")
                } else {
                    str.append(".")
                }
            }
            sub.append(str)
            */
        }

        resultQueens.append(sub)
    }

}
// @lc code=end

