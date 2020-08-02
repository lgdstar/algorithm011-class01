/*
 * @lc app=leetcode.cn id=64 lang=swift
 *
 * [64] 最小路径和
 */

// @lc code=start
class Solution {

    //1、递归(超时) 缓存递归 时间复杂度O(m * n),空间复杂度O(m * n)
    func minPathSum_1(_ grid: [[Int]]) -> Int {

        if grid.count == 0 {
            
            return 0
        }

        if grid[0].count == 0 {

            return 0
        }

        let rowCount = grid.count - 1
        let colCount = grid[0].count - 1
        var cacheArr = [[Int]](repeating: [Int](repeating: 0, count: colCount + 1), count: rowCount + 1)
        
        func path(_ row: Int, _ col: Int) -> Int {

            if row > rowCount || col > colCount {

                return 0
            }

            if row == rowCount && col == colCount {

                cacheArr[row][col] = grid[row][col]
                return cacheArr[row][col]
            }

            //使用缓存
            if cacheArr[row][col] > 0 {

                return cacheArr[row][col]
            }

            if row < rowCount && col < colCount {
                
                cacheArr[row][col] = min(path(row + 1, col), path(row, col + 1)) + grid[row][col]
            } else if row == rowCount {

                cacheArr[row][col] = path(row, col + 1) + grid[row][col]
            } else {

                cacheArr[row][col] = path(row + 1, col) + grid[row][col]
            }
            
            return cacheArr[row][col]
        }

        return path(0,0)
    }

    /*2、DP 二维数组 自底向上
    DP方程 dp[i][j] = curr + min(dp[i + 1][j], dp[i][j + 1])
    时间复杂度O(M*N)，空间复杂度O(M*N)
    */
    func minPathSum_2_1(_ grid: [[Int]]) -> Int {

        let rowCount = grid.count
        if rowCount == 0 {
            return 0
        }
        let colCount = grid[0].count
        if colCount == 0 {
            return 0
        }

        var dp = [[Int]](repeating: [Int](repeating: 0, count: colCount + 1), count: rowCount + 1)
        var row = rowCount - 1
        var col = colCount - 1

        while row >= 0 {
            
            col = colCount - 1

            while col >= 0 {

                if row == rowCount - 1 {
                    dp[row][col] = grid[row][col] +  dp[row][col + 1]
                } else if col == colCount - 1 {
                    dp[row][col] = grid[row][col] +  dp[row + 1][col]
                } else {
                    dp[row][col] = grid[row][col] + min(dp[row + 1][col], dp[row][col + 1])
                }
                
                col -= 1
            }

            row -= 1
        }

        return dp[0][0]
    }

    /* dp
    代码简化  二维数组初始化多一位用于末尾超出限制时使用
    dp方程  dp[i][j] = curr + min(dp[i - 1][j], dp[i][j - 1])  
    自顶向下，当前值为其左和其上值的较小值与当前值之和，自顶向下执行逻辑，路径和增加当前值
    */
    func minPathSum_2_2(_ grid: [[Int]]) -> Int {

        let rowCount = grid.count
        if rowCount == 0 {
            return 0
        }
        let colCount = grid[0].count
        if colCount == 0 {
            return 0
        }

        var dp = [[Int]](repeating: [Int](repeating: 0, count: colCount + 1), count: rowCount + 1)

        //dp[i + 1][j + 1]对应 grid[i][j]处的路径和，(即在外层顶部和左部增加横竖一行0)
        for i in 0..<rowCount {

            for j in 0..<colCount {
                
                if i == 0 || j == 0 {
                    //默认值为零，则首行和首列，取不为0的值与当前值求和
                    dp[i + 1][j + 1] = grid[i][j] + max(dp[i + 1][j], dp[i][j + 1])
                } else {
                    dp[i + 1][j + 1] = grid[i][j] + min(dp[i][j + 1], dp[i + 1][j])
                }
            }
        }

        return dp[rowCount][colCount]
    
    }

    //简化至一维数组
    //时间复杂度O(M*N)，空间复杂度O(N)
    func minPathSum(_ grid: [[Int]]) -> Int {
        let m = grid.count
        if m == 0 {

            return 0
        }

        let n = grid[0].count
        if n == 0 {

            return 0
        }

        var cur = [Int](repeating: 0, count: m)
        cur[0] = grid[0][0] //设置原点位置值

        for i in 1..<m {
            cur[i] = cur[i - 1] + grid[i][0] //左侧第一组数据，只需上侧数据加当前值
        }

        for j in 1..<n { //从左至右，列索引递增
            cur[0] += grid[0][j] //更新当前列首个数据值，左侧数据加当前值
            for i in 1..<m { //遍历当前列除首行外所有行
                
                cur[i] = min(cur[i - 1], cur[i]) + grid[i][j] //比较左侧数据和上侧数据取较小数据+当前值
            }
        }

        return cur[m - 1]

    }

}
// @lc code=end

