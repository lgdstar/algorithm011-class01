/*
 * @lc app=leetcode.cn id=1143 lang=swift
 *
 * [1143] 最长公共子序列
 */

// @lc code=start
class Solution {
    /*两个字符串转换为二维数组，查看状态得出dp方程
    if cha1 == cha2 { dp[i][j] = dp[i - 1][j - 1] + 1 }
    else {dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])}

    */

    //1、动态规划 二维数组  时间复杂度O(M*N), 空间复杂度O(M*N)
    func longestCommonSubsequence_1(_ text1: String, _ text2: String) -> Int {
        
        if text1.count == 0 || text2.count == 0 {

            return 0
        }

        var m = text1.count
        var n = text2.count
        
        var dp = [[Int]](repeating: [Int](repeating: 0 , count: n + 1), count: m + 1)
        var array1 = Array(text1)
        var array2 = Array(text2)

        for i in 1..<m+1 {
            
            for j in 1..<n+1 {
                
                if array1[i - 1] == array2[j - 1] {
                    //表示 去除当前的text1和text2的字符的字符串的最长公共子序列 + 1
                    dp[i][j] = dp[i - 1][j - 1] + 1
                } else {

                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
                }

            }
        }

        return dp[m][n]

    }

    //2、简化 一维数组
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {

        if text1.count == 0 || text2.count == 0 {

            return 0
        }

        let count2 = text2.count
        guard text1.count >= count2 else {
            //text1.count < count2时执行此
            return longestCommonSubsequence(text2, text1)
        }

        var dp = [Int](repeating: 0, count: count2 + 1)
        let array2 = Array(text2)

        for character in text1 {

            var last = 0 //用于标识除当前的text1和text2的字符的字符串的dp值
            for i in 1..<(count2 + 1) {

                let temp = dp[i] //数组当前存储上一组数据
                if character == array2[i - 1] {
                    //表示 去除当前的text1和text2的字符的字符串的最长公共子序列 + 1
                    dp[i] = last + 1 //前一轮数组中dp[i - 1]的值
                } else {

                    dp[i] = max(temp, dp[i - 1]) //前一轮数组中dp[i]与当前数组中dp[i - 1]取更大的
                }

                last = temp //前一轮数组中的值
            }

        }

        return dp.last!
    }
}
// @lc code=end

