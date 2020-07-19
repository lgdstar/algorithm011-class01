##学习笔记



语言应用：哈希表在Swift中，使用Set(集合)和Dictionary(字典)来表示即可



---

### Swift相关

1、堆(Heap)的实现 (待详细解析)

参考链接：

算法俱乐部：堆[1]

算法俱乐部：堆(英文)[2]

具体demo[3]



[1]:https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Heap
[2]:https://github.com/raywenderlich/swift-algorithm-club/tree/master/Heap
[3]:https://github.com/raywenderlich/swift-algorithm-club/blob/master/Heap/Heap.swift





---

###问题

1、 49字母异位词分组题目： 存在解法中使用 5的幂之和作为key的方式，此方式耗时较短， 确认使用此方式的理论依据

代码如下

```swift
let aAscII = Int("a".unicodeScalars.first!.value)
let index = Int(character.value) - aAscII 
var strKey : Int64 = 0
strKey += Int64(pow(5,Double(index))) 
```

