/*
* @lc app=leetcode.cn id=122 lang=swift
*
* [122] 买卖股票的最佳时机 II
*/


import Cocoa

var str = "Hello, playground"

/* 1、贪心算法
 时间复杂度: O(n) 遍历一遍数组
 空间复杂度: O(1)
 */
func maxProfit(_ prices: [Int]) -> Int {
    
    if prices.count <= 1 {

        return 0
    }
    var profit = 0
    for i in 1..<prices.count {
        profit += (prices[i - 1] < prices[i] ? prices[i] - prices[i - 1] : 0)

    }

    return profit
}
