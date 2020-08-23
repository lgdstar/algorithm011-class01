/*
 * @lc app=leetcode.cn id=91 lang=swift
 *
 * [91] 解码方法
 */

// @lc code=start
class Solution {

    //dp 时间复杂度：O(n)  空间复杂度：O(n) //字符串长度
    func numDecodings_1(_ s: String) -> Int {
        if s.first == "0" { //非空字符串无需空值判断
            return 0
        }

        var pre = 1, curr = 1, sArray = Array(s)
        //从前向后遍历
        for i in 1..<sArray.count {
            var tmp = curr //记录前次数据

            if sArray[i] == "0" {

                if sArray[i - 1] == "1" || sArray[i - 1] == "2" {
                    
                    curr = pre  //与回滚2个位置的解码方法数相同
                } else {

                    return 0
                }

            } else if sArray[i - 1] == "1" || (sArray[i - 1] == "2" 
            && sArray[i] >= "1" 
            && sArray[i] <= "6" ) {
                
                curr = curr + pre // dp[i] = dp[i - 1] + dp[i - 2]
            }

            //隐含分支： 其他情况， sArray[i - 1] == "0" && sArray[i] != "0" 
            //只执行pre = curr，把 sArray[i - 2]的值传入向后使用，表示当前次数与 i - 1 相同

            pre = tmp 
        }

        return curr
    }

    //外站高赞 dp  了解思路
    func numDecodings(_ s: String) -> Int {

        if s.first == "0" {

            return 0
        }

        if s.count == 1 {
            
            return 1
        }

        let sArray = Array(s)
        let length = sArray.count
        var dp = [Int](repeating: 0 , count: length + 1)
        dp[0] = 1 // 用于dp[2]的配置
        dp[1] = 1 //首个字符的dp值

        for i in 2...length {
            let first = Int(String(sArray[i - 1]))!
            let second = Int(String(sArray[i - 2]) + String(sArray[i - 1]))! //2位数

            if first >= 1, first <= 9 {
                dp[i] += dp[i - 1]
            }

            if second >= 10, second <= 26 {
                dp[i] += dp[i - 2]
            }
        }

        return dp[length]
    }


}
// @lc code=end

