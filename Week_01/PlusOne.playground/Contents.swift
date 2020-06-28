/*
 * @lc app=leetcode.cn id=66 lang=swift
 *
 * [66] 加一
 */

import Cocoa

var str = "Hello, playground"
/* 1、
 思路：
   将数组赋值为新的可变数组，对可变数组进行操作。
   将可变数组从个位向高位遍历。当前位值若为9，则令其值为0；若不为9，则值+1，返回可变数组。
   最后判断一个特殊情况（即99..9+1），若为该特殊情况，经过上述循环遍历后，所有位均为0，只需首位变为1，再将一个0压入数组尾部即可。
 时间复杂度 O(n)
*/
func plusOne(digits: [Int]) -> [Int] {
    
    var mutableArray = digits
    for index in (0...(digits.count - 1)).reversed() {
        
        if mutableArray[index] < 9 {
            
            mutableArray[index] += 1
            return mutableArray
        }
        
        mutableArray[index] = 0
    }
    
    if mutableArray[0] == 0 {
        
        // 或者 mutableArray.insert(1, at: 0)
        mutableArray[0] = 1
        mutableArray.append(0)
    }

    return mutableArray
}

plusOne(digits: [1,2,3])
plusOne(digits: [9,9,9])

/* 2、递归方式， 移除加一为0的最后一位，递归调用方法
 时间复杂度 O(n)
 */
func plusOneSecond(digits: [Int]) -> [Int] {
    let count = digits.count
    var mutableArray = digits
    let lastNum = mutableArray[(count - 1)] + 1
    if lastNum < 10 {
        mutableArray[(count - 1)] = lastNum
    }  else {
        if count == 1 {
            mutableArray = [1,0] //首位为9时，加1后变为10
        }  else {
            mutableArray.remove(at:(count - 1))
            mutableArray = plusOneSecond(digits: mutableArray)
            mutableArray.append(0)
        }
    }
    return mutableArray
}

plusOneSecond(digits: [2,1,5])
plusOneSecond(digits: [9,9,9,9])
