/*
 * @lc app=leetcode.cn id=88 lang=swift
 *
 * [88] 合并两个有序数组
 */

// @lc code=start
class Solution {

    /*
    1、暴力方法：系统方法排序
    时间复杂度：O(NlogN)
    空间复杂度：O(1)
    */
    func merge_1(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        nums1 = nums1.prefix(upTo: m) + nums2

        nums1.sort(by: {$0 < $1})
    }

    /*
    2、 双指针 从前向后
    时间复杂度 O(n)；空间复杂度 O(n)
    */
    func merge_2(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        var p1 = 0
        var p2 = 0

        var nums = nums1.prefix(upTo: m)
        nums1 = []
        
        while p1 < m, p2 < n {
            
            if nums[p1] < nums2[p2] {

                nums1.append(nums[p1])
                p1 += 1
            } else {

                nums1.append(nums2[p2])
                p2 += 1
            }
        }

        if p1 == m {

            nums1 += nums2.suffix(from: p2)
            // nums1 += nums2[p2..<nums2.endIndex] //方式2
        }
        
        if p2 == n {

            nums1 += nums.suffix(from: p1)
        }

    }

    /*
    3、双指针 从后向前
    时间复杂度O(n)；空间复杂度 O(1)
    */
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {

        var p1 = m - 1
        var p2 = n - 1
        var p  = m + n - 1

        while  p2 >= 0 {

            while p1 >= 0, nums1[p1] > nums2[p2] {

                nums1[p] = nums1[p1]
                p1 -= 1
                p  -= 1
            }

            nums1[p] = nums2[p2]
            p2 -= 1
            p -= 1
        }
    }


}
// @lc code=end

