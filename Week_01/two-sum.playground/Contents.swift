import Cocoa

var str = "Hello, playground"

//1、暴力法
func twoSum( nums: [Int], target: Int ) -> [Int] {
    
    for (index,num) in nums.enumerated() { //迭代数组的值和索引
        
        let sub = target - num
        
        for subIndex in (index + 1)..<nums.count {
            
            if sub == nums[subIndex] {
                return [index, subIndex]
            }
            
        }
    }
    
    return [0,0]
}

twoSum(nums: [2,7,11,15], target: 9)

//哈希表 方式未学习过，暂时未实现，待后续学习后补充

