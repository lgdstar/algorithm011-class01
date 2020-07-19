/*
* @lc app=leetcode.cn id=860 lang=swift
*
* [860] 柠檬水找零
*/

import Cocoa

var str = "Hello, playground"

func lemonadeChange(_ bills: [Int]) -> Bool {
     if bills.count == 0 {

         return false
     }

     //使用个数，不使用数组，空间复杂度减至O(1)
     var cash = 0
     var tenCash = 0
     for i in 0..<bills.count {

         if bills[i] == 5 {
             cash += 1
         } else if bills[i] == 10 {
             cash -= 1
             tenCash += 1
         } else {
             if  tenCash > 0 {
                 cash -= 1
                 tenCash -= 1
             } else  {
                 cash -= 3
             }
         }
        
        //优化代码：汇总判断
         if cash < 0 {
             return false
         }
     }

     return true
 }

/*
 时间复杂度：O(n)  n为bills.count
 空间复杂度：O(1)
 */
