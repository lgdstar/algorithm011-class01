/*
 * @lc app=leetcode.cn id=191 lang=swift
 *
 * [191] 位1的个数
 */

// @lc code=start
class Solution {
    
    /*
    1、 %2 /2
    时间复杂度：O(1) 。运行时间依赖于数字 n 的位数。由于这题中 n 是一个 32 位数，所以运行时间是 O(1) 的。
    空间复杂度：O(1) 。没有使用额外空间
    */
    func hammingWeight_1(_ n: Int) -> Int {

        var x = n
        var count = 0

        while x != 0 {
            
            if x % 2 == 1 { // 或使用模1来判断 x & 1 == 1
                count = count + 1
            }

            x = x >> 1 // x / 2  二进制向右一位，十进制除以2
        }

        return count
    }

    /*
    2、 x & (x - 1)  清零最低位的1
    时间复杂度：O(1) 。运行时间与 n 中位为 1 的有关。在最坏情况下， n 中所有位都是 1 。对于 32 位整数，运行时间是 O(1) 的。
    空间复杂度：O(1) 。没有使用额外空间
    */
    func hammingWeight_2(_ n: Int) -> Int {

        var x = n
        var count = 0

        while x != 0 {
            x = x & (x - 1)
            count = count + 1
        }

        return count
    }

    /*
    3、 手动循环计算 "1"的个数

    时间复杂度：O(1) 。运行时间依赖于数字 n 的位数。由于这题中 n 是一个 32 位数，所以运行时间是 O(1) 的。
    空间复杂度：O(1) 。没有使用额外空间
    */
    func hammingWeight(_ n: Int) -> Int {

        var count = 0

        let str = String(n, radix:2)

        for char in str {
            
            if char == "1" {

                count = count + 1
            }
        }
        return count
    }

}
// @lc code=end

