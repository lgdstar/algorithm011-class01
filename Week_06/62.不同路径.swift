/*
 * @lc app=leetcode.cn id=62 lang=swift
 *
 * [62] 不同路径
 */

// @lc code=start
class Solution {

    /*
        1、缓存递归(记忆化搜索)
        递归超时(时间复杂度：O(2^(m+n-1)))，
        使用缓存递归(记忆化搜索)(时间复杂度：O(m * n))  
        opt[i][j] = opt[i + 1][j] + opt[i][j + 1]  
        空间复杂度：O(m * n)
    */
    func uniquePaths_1(_ m: Int, _ n: Int) -> Int {
        
        var loc = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)

        func path(_ row: Int, _ col: Int) -> Int {

            if row == m - 1 , col == n - 1 { //终点位置
                
                loc[row][col] = 1
                return 1
            }

            if row >= m || col >= n { //底部或右侧超出部分位置(只能向下或向右走)

                return 0
            }

            if loc[row][col] > 0 {
                
                return loc[row][col]
            }

            loc[row][col] = path(row + 1, col) + path(row, col + 1)
            return loc[row][col]
        }

        return path(0, 0)
    }

    /*
    2、动态规划
    时间复杂度：O(m * n)，空间复杂度：O(m * n)
    */
    //顶部向下 递推公式：opt[i][j] = opt[i + 1][j] + opt[i][j + 1]
    func uniquePaths_2_1(_ m: Int, _ n: Int) -> Int {
        
        var loc = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)

        for i in (0..<m).reversed() {
            
            for j in (0..<n).reversed() {
                
                if i == m - 1 || j == n - 1 {

                    loc[i][j] = 1
                } else {
                    
                    loc[i][j] = loc[i + 1][j] + loc[i][j + 1]
                }
            }
        }

        return loc[0][0]
   }

    //起点设置为(m - 1,n - 1) 向下向右至 终点(0,0)，t(i,j) = t(i-1,j) + t(i,j-1), 避免for循环使用倒转
    func uniquePaths_2_2(_ m: Int, _ n: Int) -> Int {
        
        var loc = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)

        for i in 0..<m {
            
            for j in 0..<n {
                
                if i == 0 || j == 0 {

                    loc[i][j] = 1
                } else {
                    
                    loc[i][j] = loc[i - 1][j] + loc[i][j - 1]
                }
            }
        }

        return loc[m - 1][n - 1]
   }

   /* 简化 一维数组 
   起点设置为(m - 1,n - 1) 向下向右至 终点(0,0)  
   每一层左侧标识m, 从最右侧0开始 本身(即下部的值)加右侧值赋值给本身；循环n便直至最顶层
   时间复杂度：O(m * n)，空间复杂度：O(m)
   */
   func uniquePaths_2_3(_ m: Int, _ n: Int) -> Int {

       var loc = [Int](repeating: 1, count: m)

       for _ in 1..<n {

           for i in 1..<m {

               loc[i] += loc[i - 1]
           }
       }

       return  loc[m - 1]
   }

   /*
   3、数学 排列组合 
   从(m - 1 + n - 1)至(1,1)
   走到右下角一定是向右走m-1步，向下走n-1步。
   也就是说总共走 m - 1 + n - 1 = (m+n-2) 步，其中有 m - 1步是向右的。
   那么这就是一个组合的问题，从 m+n-2 步中选择 m-1 步向右(剩下步数是向下的)，总共有 C(m+n-2,m-1) 种排列方式
   */
   func uniquePaths(_ m: Int, _ n: Int) -> Int {

       var ans : Int64 = 1

       for i in 0..<min(m - 1, n - 1) {
           
           ans *= Int64(m + n - 2 - i)
           ans /= Int64(i + 1)
       }

       return Int(ans)
   }

}
// @lc code=end

