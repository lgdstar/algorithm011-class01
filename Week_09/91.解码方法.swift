/*
 * @lc app=leetcode.cn id=91 lang=swift
 *
 * [91] 解码方法
 */

// @lc code=start
class Solution {

    //1、dp 时间复杂度：O(n)  空间复杂度：O(n) //字符串长度
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
                    
                    curr = pre  //与回滚2个位置的解码方法数相同 dp[i] = dp[i - 2]
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

    //2、外站高赞 dp  了解思路
    func numDecodings_2(_ s: String) -> Int {

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

    //3、递归 超时 时间复杂度: O(n^2)
    func numDecodings_3(_ s: String) -> Int {

        var sArray = Array(s)
        let count = sArray.count
        //从后向前
        func numDecodings(_ index: Int) -> Int {
            if index == count {
                return 1 
            }

            if sArray[index] == "0" {
                return 0
            }

            var res = numDecodings(index + 1)

            if index < count - 1,  //两位数，index需留出至少两位
            (sArray[index] == "1" || (sArray[index] == "2" && sArray[index + 1] < "7")) {

                res += numDecodings(index + 2)
            }

            return res
        }

        return numDecodings(0)
    }

    //记忆化递归 时间复杂度:O(n)
    func numDecodings_3_1(_ s: String) -> Int {

        var sArray = Array(s)
        let count = sArray.count
        var memo = [Int](repeating: -1 , count: count + 1)
        memo[count] = 1

        //从后向前
        func numDecodings(_ index: Int) -> Int {
            if memo[index] > -1 {
                return memo[index]
            }

            if sArray[index] == "0" {
                memo[index] = 0
                return 0
            }

            var res = numDecodings(index + 1)

            if index < count - 1,  //两位数，index需留出至少两位
            (sArray[index] == "1" || (sArray[index] == "2" && sArray[index + 1] < "7")) {

                res += numDecodings(index + 2)
            }

            memo[index] = res
            return res
        }

        return numDecodings(0)
    }

    //4、dp 一维数组 从后向前
    func numDecodings_4(_ s: String) -> Int {

        var sArray = Array(s)
        var dp = [Int](repeating: 0, count: sArray.count + 1)
        dp[sArray.count] = 1

        var i = sArray.count - 1
        while i >= 0 {
            
            if sArray[i] == "0" {
                dp[i] = 0
            } else {

                dp[i] = dp[i + 1]
                if i < sArray.count - 1,  //两位数，index需留出至少两位
            (sArray[i] == "1" || (sArray[i] == "2" && sArray[i + 1] < "7")) {

                dp[i] += dp[i + 2]
                }
            }
            
            i -= 1
        }

        return dp[0]
    }

    // 常数空间
    func numDecodings(_ s: String) -> Int {

        var curr = 1, pre = 0, sArray = Array(s)

        var i = sArray.count - 1
        while i >= 0 {
            
            var tmp = sArray[i] == "0" ? 0 : curr

            if i < sArray.count - 1,  //两位数，index需留出至少两位
            (sArray[i] == "1" || (sArray[i] == "2" && sArray[i + 1] < "7")) {

                tmp += pre
            }

            pre = curr
            curr = tmp
            
            i -= 1
        }

        return curr
    }

}
// @lc code=end

