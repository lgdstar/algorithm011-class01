#学习笔记

####链表

 1、定义 linked list

+ 单链表的一个存储结点(node)包含两个部分，其中，data部分称为数据域，用于存储线性表的一个数据元素，其数据类型由应用问题决定。 link部分称为指针域或链域，用于存放一个指针，该指针指示链表中下一个结点的开始存储地址
+ 链表的最后一个结点没有后继，在结点的link域中放一个空指针NULL
+ 对单链表中任一结点的访问必须首先根据头指针找到第一个结点，再按有关各结点链域中存放的指针位置往下找，直到找到所需结点

2、时间复杂度

| prepend | append | lookup | insert | delete |
| :-----: | :----: | :----: | :----: | :----: |
|  O(1)   |  O(1)  |  O(n)  |  O(1)  |  O(1)  |

> prepend 从头结点增加；append从尾结点增加

3、swift代码实现

```swift
/// 链表节点类
public class ListNode<T> {
    var value: T  // 值
    var next: ListNode<T>? = nil // 下一个节点
    weak var previous: ListNode<T>? = nil
    init(value: T) {
        self.value = value
        
    }
}

/// 链表类
public class LinkedList<T: Equatable> {
    fileprivate var head: ListNode<T>? // 链表的头
    private var tail: ListNode<T>?    // 链表的尾
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: ListNode<T>? {
        return head
    }
    
    public var last: ListNode<T>? {
        return tail
    }
    
   //尾部增加结点，传入结点参数
    public func append(node: ListNode<T>) {
        if let tailNode = tail {
            tailNode.next = node
//            node.previous = tailNode
        }else {
            head = node
        }
        tail = node
    }
  
    //尾部增加结点，传入结点数据
    public func append(value: T) {
        let newNode = ListNode<T>.init(value: value)
    
        if let tailNode = tail {
            tailNode.next = newNode
            newNode.previous = tailNode
        }else {
            head = newNode
        }
        tail = newNode
    }
    
    /// node节点后插入值为val的节点
    /// - Parameter node: 目标节点
    /// - Parameter val: 插入的节点的值
    func insert(node: ListNode<T>, val: T) {
        let newNode = ListNode<T>.init(value: val)
        newNode.next = node.next
        node.next = newNode
    }
    
    //查询结点
    public func nodeAt(index: Int) -> ListNode<T>? {
        guard index >= 0 else {
            return nil
        }
        var i = index
        var node = head
        while node != nil {
            if i == 0 {
                return node
            }
            node = node?.next
            i -= 1
        }
        return nil
    }
    
    public func removeAll() {
        self.head = nil
        self.tail = nil
    }
    
    /// 删除一个节点（单向链表）
    /// - Parameter node: 要删除的节点
    /// 当需要删除一个节点p时，只需要将p的前一个节点的next赋为p->next,但是由于是单向的，只知道p，无法知道p前一个节点，所以需要转换思路。将p下一个的节点覆盖到p节点即可，这样就等效于将p删除了。
    func deleteNode(node: ListNode<T>) {
        if let next = node.next {
            node.value = next.value
            node.next = next.next
        }else {
            self.pop()
        }
        
    }
    
    public func remove(node: ListNode<T>) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
    
    /// 去掉最后一个节点
    public func pop() -> T? {
        
        /// 存在最后一个节点
        if let last = tail {
            /// 存在最后一个节点的前一个节点
            if let lp = last.previous {
                lp.next = nil
                tail = lp
            }else {/// 不存在
                head = nil
                tail = nil
            }
        }
        tail?.previous = nil
        tail?.next = nil
        return tail?.value
    }
}

```

使用

```swift
let dogbreeds = LinkedList<String>()

let d = ListNode.init(value: "Labrador")
let Bulldog = ListNode.init(value: "Bulldog")
let Beagle = ListNode.init(value: "Beagle")
let Husky = ListNode.init(value: "Husky")

dogbreeds.append(node: d)
dogbreeds.append(node: Bulldog)
dogbreeds.append(node: Beagle)
dogbreeds.append(node: Husky)
dogbreeds.append(node: Bulldog)

dogbreeds.nodeAt(index: 0)
dogbreeds.nodeAt(index: 0)?.value == dogbreeds.nodeAt(index: 4)?.value
dogbreeds.nodeAt(index: 2)
dogbreeds.nodeAt(index: 3)
```

参考地址：

[Swift-链表](https://www.jianshu.com/p/992c148b9b29)、[Link-list(链表)-Swift实现](https://www.jianshu.com/p/7d1f7a6b4ab5)

4、算法中使用

+ 单链表简单使用 数据域数据类型为Int

```swift
//链表类
class ListNode {
    var val: Int
    var next: ListNode?
    
    init() {
        self.val = 0
        self.next = nil
    }
    
    init(val: Int) {
        self.val = val
        self.next = nil
    }
    
    init(val: Int, next: ListNode) {
        self.val = val
        self.next = next
    }
}
```

使用示例：[leetcode21](https://leetcode-cn.com/problems/merge-two-sorted-lists/) 合并两个有序链表 

递归算法实现(playground中实现)

```swift
func mergeTwoListsF(l1: ListNode?, l2: ListNode?) -> ListNode? {
    
    if l1 == nil {
        
        return l2
    } else if l2 == nil {
        
        return l1
    } else if (l1?.val)! < (l2?.val)! { //可变对象的属性对比需强转
        
        l1?.next = mergeTwoListsF(l1: l1?.next, l2: l2)
        return l1
    } else {
        l2?.next = mergeTwoListsF(l1: l1, l2: l2?.next)
        return l2
    }
}

//测试用例 (1,2,4) (1,3,4)
var result = mergeTwoListsF(l1: ListNode(val: 1, next: ListNode(val: 2, next: ListNode(val: 4))), l2: ListNode(val: 1, next: ListNode(val: 3, next: ListNode(val: 4))))

//打印结果：循环输出结点val
while result != nil  {
    
    print((result?.val)!) //强转以防止警告
    result = result?.next
}
```



#### 双端队列 Deque



