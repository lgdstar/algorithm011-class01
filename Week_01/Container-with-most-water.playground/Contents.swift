/*
* @lc app=leetcode.cn id=11 lang=swift
*
* [11] 盛最多水的容器
*/

import Cocoa

var str = "Hello, playground"

//1.暴力解法：两层for循环  时间复杂度:O(n^2)
func maxArea(height: [Int]) -> Int {

    var maxVolume = 0

    for i in 0..<(height.count - 1) { //只需到倒数第二个元素，最后一个留给右侧边界
        for j in (i + 1)..<height.count {   //从第i + 1个元素至最后一个元素
            let currentVolume = (j - i) * min(height[i],height[j])
            maxVolume = max(maxVolume, currentVolume)
        }
    }

    return maxVolume
}

/*2.双指针法
  左右夹逼，从低的一测向里，计算容量是否更大，更大则覆盖原容量
  时间复杂度 O(n) 双指针总计最多遍历整个数组一次
  空间复杂度：O(1)，只需要额外的常数级别的空间
 */
func maxAreaS(height: [Int]) -> Int {
    
    var left = 0
    var right = height.count - 1
    var maxVolume =  0

    while right > left   {

        maxVolume = max(maxVolume, (right - left) * min(height[right] ,height[left]))
        if height[left] >= height[right] {
            right -= 1
        } else {
            left += 1
        }
    }

    return maxVolume
}

