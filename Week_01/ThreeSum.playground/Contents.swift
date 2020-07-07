/*
* @lc app=leetcode.cn id=15 lang=swift
*
* [15] 三数之和
*/

import Cocoa

var str = "Hello, playground"

//1、暴力解法，3个for循环，耗时较多 时间复杂度O(n^3)

/*2、 双指针
 首先对数组排序，遍历最左侧元素， 在其右侧元素中，进行双指针夹逼来循环获取结果
 
 时间复杂度： O(N^2)
 空间复杂度：使用了一个额外的数组存储了 nums 的副本并进行排序，空间复杂度为 O(N)
 */
func threeSum(_ nums: [Int]) -> [[Int]] {
    var group = [[Int]]()
    if  nums.count < 3 {
        
        return group
    }
    var sortNums = nums
    sortNums.sort(by: {$0 < $1})  //可变数组排序
    // var sortNums = nums.sorted() //不可变数组排序，比可变数组排序耗时平均多大约30ms
    
    for  i in 0...(sortNums.count - 3) {
        if sortNums[i] > 0 {break}  // 最小值大于0
        if i > 0 , sortNums[i] == sortNums[i - 1] { continue} // 与前一索引值相同，则其符合组合已经包含在内，无需再次计算
        
        var j = i + 1
        var k = sortNums.count - 1
        while k > j {
            let sum = sortNums[i] + sortNums[j] + sortNums[k]
            if sum > 0 {
                k -= 1  //可减少排重代码，排重循环和外界循环耗时没区别
            } else if sum < 0 {
                j += 1
            } else {
                let rightnum = [sortNums[i],sortNums[j],sortNums[k]]
                group.append(rightnum)
                
                while k > j, sortNums[j] == sortNums[j + 1] { //去除中间重复相同元素，同时防止下标溢出
                    j += 1
                }
                
                while k > j, sortNums[k] == sortNums[k - 1]  { //去除中间重复相同元素，同时防止下标溢出
                    k -= 1
                }
                
                j += 1 //去重后需再进行操作一次，当前值为重复值
                k -= 1 //去重后需再进行操作一次，当前值为重复值
            }
        }
    }
    return group
}
