import Cocoa

var str = "Hello, playground"

//1、暴力法 两层for循环 时间复杂度O(n^2)  空间复杂度O(1)
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

//哈希表  swift中哈希表应用于 Dictionary 和 Set

//2、两遍Hash表， 时间复杂度O(n)  空间复杂度O(n)
func twoSumHashTwice( nums: [Int], target: Int ) -> [Int] {
    
    var dic = [Int: Int]()
    
    for i in 0..<nums.count {
        
        dic[nums[i]] = i  //以值为key, 索引值为value
    }
    
    for i in 0..<nums.count {
        
        let sub = target - nums[i]
        
        if dic.keys.contains(sub) == true  {
            
             if sub != nums[i] || dic[sub] != i { //去除自身重复
                
                return [i,dic[sub]!]
            }
        }
    }
    
    return []
    
}

twoSumHashTwice(nums: [2,7,11,15], target: 9)

//3、一遍Hash表， 时间复杂度O(n)  空间复杂度O(n)
func twoSumHashOnce( nums: [Int], target: Int ) -> [Int] {
    
    var dic = [Int: Int]()
    
    for i in 0..<nums.count {
        
        let sub = target - nums[i]
        
        if dic.keys.contains(sub) == true  {
            
            return [dic[sub]!,i] //无需去除自身重复，此时自身还未添加到字典中; 由于在索引值高的两值之一时才能匹配到，所以此时i值较大放后面
        } else {
            
            dic[nums[i]] = i  //以值为key, 索引值为value
        }
        
    }
    
    return []
    
}

//代码更简化版本
func twoSumHashOnceSimplify(_ nums: [Int], _ target: Int) -> [Int] {
    var dict: [Int: Int] = [:]
    for i in 0..<nums.count {
        guard let j = dict[target - nums[i]] else {  //使用赋值判断来判定另一值是否存在
            dict[nums[i]] = i
            continue
        }
        return [j, i]
    }
    return []
}
