/*
* @lc app=leetcode.cn id=242 lang=swift
*
* [242] 有效的字母异位词
*/

import Cocoa

var str = "Hello, playground"


/*1、排序
时间复杂度：O(nlogn)，假设 n 是 s 的长度，排序成本O(nlogn) 和比较两个字符串的成本 O(n)。排序时间占主导地位，总体时间复杂度为 O(nlogn)
空间复杂度：O(1)，空间取决于排序实现，如果使用 heapsort，通常需要 O(1) 辅助空间。  Swift语言实现方式待确认!!!
 
 */

func isAnagram(_ s: String, _ t: String) -> Bool {

    return s.sorted() == t.sorted()
}

/* 2、哈希表 : 有限数组代替哈希表
 时间复杂度：O(n)。时间复杂度为 O(n) 因为访问数组是一个固定的时间操作。
 空间复杂度：O(1)。尽管我们使用了额外的空间，但是空间的复杂性是 O(1)，因为无论 N 有多大，表的大小都保持不变。

 */
func isAnagramHashF(_ s: String, _ t: String) -> Bool {
     if s.count != t.count {
          return false
     }
    
    var counter = [Int](repeating: 0, count: 26)
    let aAscII = Character("a").asciiValue!
    
    for i in s {
        
        counter[Int(i.asciiValue! - aAscII)] += 1
    }
    
    for i in t {
        
        counter[Int(i.asciiValue! - aAscII)] -= 1
        
        if counter[Int(i.asciiValue! - aAscII)] < 0 {
            //不存在相同索引值的正值抵消，可认为存在字符不同
            return false
        }
    }
    
    return true
}

//AscII码值获取的另一种，存在少许时间优化
func isAnagramHashS(_ s: String, _ t: String) -> Bool {
     if s.count != t.count {
          return false
     }
    
    var counter = [Int](repeating: 0, count: 26)
    let aAscII = Int("a".unicodeScalars.first!.value)
    
    for i in s.unicodeScalars {
        
        counter[Int(i.value) - aAscII] += 1
    }
    
    for i in t.unicodeScalars {
        
        counter[Int(i.value) - aAscII] -= 1
        
    }
    
    guard counter.first(where: {$0 != 0}) == nil else {
        //查询到不为0的元素
        return false
    }
    
    return true
}

/*
 进阶问题：如果输入字符串包含 unicode 字符怎么办？你能否调整你的解法来应对这种情况？
 
 使用哈希表而不是固定大小的计数器。想象一下，分配一个大的数组来适应整个 Unicode 字符范围，这个范围可能超过 100万。哈希表是一种更通用的解决方案，可以适应任何字符范围。
 
 使用字典创建 键值对来实现进阶的问题
 */

func isAnagramHashEx(_ s: String, _ t: String) -> Bool {
     if s.count != t.count {
          return false
     }
    
    var counter = [Int: Int]()
    
    for i in s.unicodeScalars {
        
        if counter.keys.contains(Int(i.value)) == true {

            counter[Int(i.value)]! += 1
        } else {

            counter[Int(i.value)] = 1
        }
        
    }
    
    for i in t.unicodeScalars {
        
        if counter.keys.contains(Int(i.value)) == false {
            
            return false
        }
        
        counter[Int(i.value)]! -= 1
        
        if counter[Int(i.value)]! < 0 {
            //不存在相同索引值的正值抵消，可认为存在字符不同
            return false
        }
    }
    
    return true
}

isAnagramHashEx("🎉🍵🍵", "🍵🍵🎉")

//进阶问题 简化代码
func isAnagramHashExS(_ s: String, _ t: String) -> Bool {
     if s.count != t.count {
          return false
     }
    
    var counter = [Int: Int]()
    
    for i in s.unicodeScalars {
        
        //简化
        counter[Int(i.value), default: 0] += 1
    }
    
    for i in t.unicodeScalars {
        
        counter[Int(i.value), default: 0] -= 1
        
        if counter[Int(i.value)]! < 0 {
            //不存在相同索引值的正值抵消，可认为存在字符不同
            return false
        }
    }
    
    return true
}
