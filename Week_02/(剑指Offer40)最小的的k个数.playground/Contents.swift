
/*
* @lc app=leetcode.cn id= lang=swift
*
* 剑指Offer40.最小的k个数
*/

import Cocoa

var str = "Hello, playground"

/*
 1、暴力排序
 时间复杂度：O(nlogn)，其中 n 是数组 arr 的长度。算法的时间复杂度即排序的时间复杂度。
 空间复杂度：O(logn)，排序所需额外的空间复杂度为 O(logn)
 */

func getLeastNumbers(_ arr: [Int], _ k: Int) -> [Int] {
    
    var sortedArray = arr
    sortedArray.sort(by: {$0 < $1}) //升序排序
    
    return Array(sortedArray.prefix(upTo: k)) //取前k个
}

//测试
getLeastNumbers([3,2,1], 2)


/*
 2、堆
 我们用一个大根堆实时维护数组的前 k 小值。
 首先将前k个数插入大根堆中，随后从第k+1个数开始遍历，
 如果当前遍历到的数比大根堆的堆顶的数要小，就把堆顶的数弹出，再插入当前遍历到的。
 最后将大根堆里的数存入数组返回即可

 时间复杂度：O(nlogk)，其中 n 是数组 arr 的长度。由于大根堆实时维护前 k 小值，所以插入删除都是 O(logk) 的时间复杂度，最坏情况下数组里 n 个数都会插入，所以一共需要 O(nlogk) 的时间复杂度
 空间复杂度：O(k)，因为大根堆里最多 k 个数。
 */

/**
 * 堆的实现
 */
public struct Heap<T> {
    
    var nodes = [T]()
    
    private var orderCriteria: (T, T) -> Bool
    
    
    public init(sort: @escaping(T, T) -> Bool) {
        self.orderCriteria = sort
    }
    /// 用数组创建堆
    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
        configureHeap(from: array)
    }
    
    private mutating func configureHeap(from array: [T]) {
        nodes = array
        for i in stride(from: (nodes.count/2 - 1), through: 0, by: -1) {
            shiftDown(i)
        }
    }
    
//    private mutating func buildHeap(fromArray array: [T]) {
//        elements = array
//        for i in stride(from: (nodes.count/2-1), through: 0, by: -1) {
//            shiftDown(index: i, heapSize: elements.count)
//        }
//    }
    
    public var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    public var count: Int {
        return nodes.count
    }
    
    ///
    @inline(__always) internal func parentIndex(ofIndex i: Int) -> Int {
        return (i - 1) / 2
    }
    
    @inline(__always) internal func leftChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 1
    }
    
    @inline(__always) internal func rightChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 2
    }
    
    public func peek() -> T? {
        return nodes.first
    }
    
    public mutating func insert(_ value: T) {
        nodes.append(value)
        shiftUp(nodes.count - 1)
    }
    
    public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        for value in sequence {
            insert(value)
        }
    }
    
    public mutating func replace(index i: Int, value: T) {
        guard i < nodes.count else {
            return
        }
    }
    /// 删除根节点
    @discardableResult public mutating func remove() -> T? {
        guard !nodes.isEmpty else {
            return nil
        }
        
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(0)
            return value
        }
    }
    /// 删除任意节点
    @discardableResult public mutating func remove(at index: Int) -> T? {
        guard index < nodes.count else { return nil }
        
        let size = nodes.count - 1
        if index != size {
            nodes.swapAt(index, size)
            shiftDown(from: index, until: size)
            shiftUp(index)
        }
        return nodes.removeLast()
    }
    /// 向上移动
    internal mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let child = nodes[childIndex]
        var parentIndex = self.parentIndex(ofIndex: childIndex)
        
        while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
            nodes[childIndex] = nodes[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofIndex: childIndex)
        }
        
        nodes[childIndex] = child
    }
    /// 向下移动
    internal mutating func shiftDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = self.leftChildIndex(ofIndex: index)
        let rightChildIndex = leftChildIndex + 1
        
        var first = index
        if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
            first = rightChildIndex
        }
        if first == index { return }
        
        nodes.swapAt(index, first)
        shiftDown(from: first, until: endIndex)
    }
    
    internal mutating func shiftDown(_ index: Int) {
        shiftDown(from: index, until: nodes.count)
    }
}

func getLeastNumbers_2(_ arr: [Int], _ k: Int) -> [Int] {
    var result = [Int]()
    if k == 0 {
        return result
    }
    
    var maxHeap = Heap<Int>(sort: >) //初始化大根堆
    for i in 0..<k {
        maxHeap.insert(arr[i]) //在堆中放入k个元素
    }
    
    for i in k..<arr.count {
        
        if arr[i] < maxHeap.peek()! { //若k后元素比大根堆顶小，则移除大根堆顶，插入新数据
            maxHeap.remove()
            maxHeap.insert(arr[i])
        }
    }
    
    for _ in 0..<k {
        result.append(maxHeap.peek()!) //从堆中取出数据放入数组
        maxHeap.remove()
    }
   
    return result
}

//测试
getLeastNumbers_2([3,2,1], 2)

/*
 3、快速排序方法
 时间复杂度：期望为 O(n) ，由于证明过程很繁琐，所以不再这里展开讲。具体证明可以参考《算法导论》第 9 章第 2 小节。
 最坏情况下的时间复杂度为 O(n^2)。情况最差时，每次的划分点都是最大值或最小值，一共需要划分 n - 1 次，而一次划分需要线性的时间复杂度，所以最坏情况下时间复杂度为 O(n^2)。

 空间复杂度：期望为 O(log⁡n)，递归调用的期望深度为 O(log⁡n)，每层需要的空间为 O(1)，只有常数个变量。
 最坏情况下的空间复杂度为 O(n)。最坏情况下需要划分 n 次，即 randomized_selected 函数递归调用最深 n - 1 层，而每层由于需要 O(1) 的空间，所以一共需要 O(n) 的空间复杂度
 
 */

func quickSort(_ arr: inout [Int], _ left: Int, _ right: Int) {
    
    if left >= right || arr.count <= 1 {
        
        return
    }
    
    let partitionIndex: Int = partition(&arr, left, right)
    quickSort(&arr, left, partitionIndex - 1)
    quickSort(&arr, partitionIndex + 1, right)
}

func partition(_ arr: inout [Int], _ left: Int, _ right: Int) -> Int { //分区操作
    
    let pivot = left  //设定基准值
    var index = pivot + 1  //从基准值+1开始
    
    for i in index...right { //注意界限，包含最后的值
        if arr[i] < arr[pivot] {
            
            (arr[i], arr[index]) = (arr[index], arr[i]) //交换数据，小于基准的放在索引值位置
            index += 1
        }
    }
    
    //交换数据 把基准值与最后一个小于他的数据交互，放置与中间位置
    (arr[index - 1], arr[pivot]) = (arr[pivot], arr[index - 1])
    
    return index - 1
}

func getLeastNumbers_3(_ arr: [Int], _ k: Int) -> [Int] {
    
    if k == 0 || arr.isEmpty {
        return []
    }
    
    if k == arr.count {
        return arr
    }
    
    var arrM = arr
    quickSort(&arrM, 0, arr.count - 1)
    return  Array(arrM.prefix(k))
}

getLeastNumbers_3([3,2,1], 2)

func quickSort(_ arr: inout [Int], _ left: Int, _ right: Int, _ k: Int) {
    
    if left >= right || arr.count <= 1 {
        
        return
    }
    
    let partitionIndex: Int = partition(&arr, left, right)
    //使用k值进行优化
    if partitionIndex == k {
        return
    } else if partitionIndex > k - 1 {
        
        quickSort(&arr, left, partitionIndex - 1, k)
    } else {
        
        quickSort(&arr, partitionIndex + 1, right, k)
    }
}

func getLeastNumbers_4(_ arr: [Int], _ k: Int) -> [Int] {
    
    if k == 0 || arr.isEmpty {
        return []
    }
    
    if k == arr.count {
        return arr
    }
    
    var arrM = arr
    quickSort(&arrM, 0, arr.count - 1, k)
    return  Array(arrM.prefix(k))
}

getLeastNumbers_4([3,2,1], 2)
