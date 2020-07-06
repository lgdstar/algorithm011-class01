
/*
* @lc app=leetcode.cn id=26 lang=swift
*
* [26] 删除排序数组中的重复项
*/

import Cocoa

var str = "Hello, playground"

/*
 你不需要考虑数组中超出新长度后面的元素。
 表明可不进行实际删除，只需把多余元素移动至右侧，移动不重复的元素到左边，无需考虑右侧多余元素的顺序和值
 */

/* 双指针法
 
 数组完成排序后，我们可以放置两个指针 i 和 j，其中 i 是慢指针，而 j 是快指针。只要 nums[i] = nums[j]，我们就增加 j 以跳过重复项。
 当我们遇到 nums[j] != nums[i]时，跳过重复项的运行已经结束，因此我们必须把它（nums[j]）的值复制到 nums[i + 1]。然后递增 i，接着我们将再次重复相同的过程，直到 j 到达数组的末尾为止。
 
 时间复杂度：O(n)，假设数组的长度是 n，那么 i 和 j 分别最多遍历 n 步。
 空间复杂度：O(1)。
 */
func removeDuplicates(nums: inout [Int]) -> Int {
    
    if nums.count == 0 {
        
        return 0
    }
    
    var i = 0
    
    for j in 1..<nums.count {
        
        if nums[j] != nums[i] { //在i+1位置设置新的不重复元素
            
            i += 1
            nums[i] = nums[j]
        }
    }
    
    return i + 1
}
