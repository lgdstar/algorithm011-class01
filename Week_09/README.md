## 学习笔记

#### 算法相关

##### 1、leetcode 63 不同路径 II 状态转移方程

```swift
if obstacleGrid[i][j] == 1  {
  dp[i][j] = 0  //障碍物
} else {
  dp[i][j] = dp[i + 1][j] + dp[i][j + 1] //自底向上
} 
```



##### 2、字符串相关算法优化

* 字符串使用遍历字符串方式比把字符串转化为字符数组执行更快速

```swift
let str = "string"
Array(str) //把字符串转化为字符数组

for c in str { //遍历字符串
  print(c)
}

```

* 字符串使用 "a".unicodeScalars.first!.value 方式比 Character("a").asciiValue! 方式更节省时间，但是占用空间稍有增大

```swift
//示例：记录字符串中字符显示次数 (字符串只有小写字母)
let str = "string"
var array = [Int](repeating: 0 , count: 26)

//方式1
let a = Int("a".unicodeScalars.first!.value)
for c in str.unicodeScalars { 
  
  array[Int(c.value) - a] += 1
}

//方式二
let a = Int(Character("a").asciiValue!)
for c in str {
  
  array[Int(c.asciiValue!) - a] += 1
}

```



----

#### Swift相关

##### 1、经验总结

* 对 ?: 三目运算符最好添加()包裹，以便在多个此运算符连续使用时，正确执行逻辑 



##### 2、字符的 Ascii 码值获取

```swift
//方式1
let a = Int("a".unicodeScalars.first!.value)

//方式2
let a = Int(Character("a").asciiValue!)
```

