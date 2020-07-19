/*
 * @lc app=leetcode.cn id=49 lang=swift
 *
 * [49] 字母异位词分组
 */

// @lc code=start


class Solution {

/*
1、暴力方法： 对所有字符串排序成字符数组， 以字符数组为key，字符组成的数组为value存入字典
时间复杂度：O(NKlogK)，其中 N 是 strs 的长度，而 K 是 strs 中字符串的最大长度。当我们遍历每个字符串时，外部循环具有的复杂度为 O(N)。
然后，我们在 O(KlogK) 的时间内对每个字符串排序
空间复杂度：O(NK) 排序存储在 strDic中的全部信息内容
*/
    func groupAnagrams_1(_ strs: [String]) -> [[String]] {

        var strDic = [[Character] : [String]]()

        for string in strs {
            
            var charArray = string.sorted()

            strDic[charArray, default: []].append(string)
        }

        return Array(strDic.values)
    }

/*2、使用计数分类。我们可以将每个字符串 s 转换为字符数 count，由26个非负整数组成，表示 a，b，c 的数量等。我们使用这些计数作为哈希映射的基础。
时间复杂度：O(NK)，其中 N 是 strs 的长度，而 K 是 strs 中字符串的最大长度。计算每个字符串的字符串大小是线性的，我们统计每个字符串
空间复杂度：O(NK) 排序存储在 strDic中的全部信息内容
*/
    func groupAnagrams(_ strs: [String]) -> [[String]] {

    var strDic = [[Int] : [String]]()
    let first = Int("a".unicodeScalars.first!.value) //或者直接使用 97
    for string in strs {
        
        var keyArray = [Int](repeating: 0, count: 26)

        for char in string.unicodeScalars {

            keyArray[Int(char.value) - first] += 1
        }

        //可替换语句
        // if let strings = strDic[keyArray] {
            
        //     strDic[keyArray] = strings + [string]
        // } else {
        //     strDic[keyArray] = [string]
        // }
        strDic[keyArray, default: []].append(string)
    }

    return Array(strDic.values)
    }


/*
3、质数作为乘法因子形成的正数作为字符串映射
 依据理论：
 算术基本定理，又称为正整数的唯一分解定理，即：每个大于1的自然数，要么本身就是质数，要么可以写为2个以上的质数的积，而且这些质因子按大小排列之后，写法仅有一种方式
  
  不考虑Int溢出时可使用
*/
    func groupAnagrams_3(_ strs: [String]) -> [[String]] {
    
    var strsArray = [[String]]()
    var strDic: Dictionary = [Int: [String]]()
    //质数数组
    var prime = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103]

    let aAscII = Int("a".unicodeScalars.first!.value)
    for string in strs {
        
        var strKey = 1
        
        for character in string.unicodeScalars {
            
            let index = Int(character.value) - aAscII //字母的排序为质数索引
            strKey = strKey * prime[index] //累乘
        }
        
        if strDic.keys.contains(strKey)  {  //存在则插入，不存在进行创建
            
            strDic[strKey]!.append(string)
        } else {
            
            strDic[strKey] = [string]
        }
    }
    
    for array in strDic.values {
        
        strsArray.append(array)
    }
    
    return strsArray
    }

    /*4、有使用 5的幂的和 作为映射，进行尝试
    存在溢出： 示例
    ["zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz","zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzfoobar"]
    */
   func groupAnagrams_4(_ strs: [String]) -> [[String]] {
    
    var strDic: Dictionary = [Int64: [String]]()
    let aAscII = Int("a".unicodeScalars.first!.value)

    for string in strs {
        
        var strKey : Int64 = 0
        
        for character in string.unicodeScalars {
            
            let index = Int(character.value) - aAscII 
            strKey += Int64(pow(5,Double(index)))  // 使用字符5的幂之和
        }

        strDic[strKey, default: []].append(string)
    }
    
    return Array(strDic.values)
    }

}
// @lc code=end

