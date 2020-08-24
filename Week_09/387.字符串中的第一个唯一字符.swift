/*
 * @lc app=leetcode.cn id=387 lang=swift
 *
 * [387] 字符串中的第一个唯一字符
 */

// @lc code=start
class Solution {
    /* 
    1、Hash表 
    时间复杂度：O(n)
    空间复杂度：O(n)
    */
    func firstUniqChar_1(_ s: String) -> Int {

        var sArray = Array(s)
        var sDic = [Character: Int]()

        for i in 0..<sArray.count {

            sDic[sArray[i], default: 0] += 1
        }

        for i in 0..<sArray.count {
            
            if sDic[sArray[i]] == 1 {
                
                return i
            }
        }

        return -1
    }

    //第二次循环优化，在字符串只包含小写字母的
    func firstUniqChar_1_2(_ s: String) -> Int {

        var sArray = Array(s)
        var sDic = [Character: Int]()

        for i in 0..<sArray.count {

            sDic[sArray[i], default: 0] += 1
        }

        var minIndex = sArray.count
        for key in sDic.keys { //遍历字典keys，注：字典的keys不是数组无法使用数组的语法糖
            
            if sDic[key] == 1 {
                
                minIndex = min(minIndex, sArray.firstIndex(of: key)!)
            }
        }

        return minIndex == sArray.count ? -1 : minIndex
    }

     /* 
    2、遍历字符串 
    时间复杂度：O(n)
    空间复杂度：O(1)
    */
    func firstUniqChar_2(_ s: String) -> Int {

        var array = [Int](repeating: 0, count: 26)
        let aAscii = Int(Character("a").asciiValue!)

        for c in s {
            
            array[Int(c.asciiValue!) - aAscii] += 1
        }

        var res = 0
        for c in s {
            
            if array[Int(c.asciiValue!) - aAscii] == 1 {

                return res
            }

            res += 1
        }

        return -1
    }

    /*
    遍历字符串方式2 
    使用 "a".unicodeScalars.first!.value 方式比 Character("a").asciiValue! 方式 
    节省时间，但是占用空间增大
    时间复杂度: O(n)
    空间复杂度: O(1) //针对字符串只包含小写字母
    */
    func firstUniqChar(_ s: String) -> Int {

        var array = [Int](repeating: 0, count: 26)
        let aAscii = Int("a".unicodeScalars.first!.value)

        for c in s.unicodeScalars {
            
            array[Int(c.value) - aAscii] += 1
        }

        var res = 0
        for c in s.unicodeScalars {
            
            if array[Int(c.value) - aAscii] == 1 {

                return res
            }

            res += 1
        }

        return -1
    }

}
// @lc code=end

