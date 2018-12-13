####  1 dispatch_apply

dispatch_apply 是按照**指定的次数**将**指定的block** 添加到**指定的queue**当中去。

可以用于快速的迭代

```objective-c
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 迭代数组
    NSLog(@"begin");
    NSArray *arr = @[@"apple",@"orange",@"watermelon",@"banana"];
    dispatch_apply(arr.count, queue, ^(size_t idx) {
        NSLog(@"idx-%@",arr[idx]);
    });
    NSLog(@"end");

// 打印结果
2018-12-13 11:36:00.915525+0800 Dispatch_apply_demo[6696:100664] begin
2018-12-13 11:36:00.915688+0800 Dispatch_apply_demo[6696:100664] idx-apple
2018-12-13 11:36:00.915696+0800 Dispatch_apply_demo[6696:100700] idx-orange
2018-12-13 11:36:00.915712+0800 Dispatch_apply_demo[6696:100695] idx-watermelon
2018-12-13 11:36:00.915717+0800 Dispatch_apply_demo[6696:100698] idx-banana
2018-12-13 11:36:00.915878+0800 Dispatch_apply_demo[6696:100664] end
```



#### 2 dispatch_suspend 挂起指定的queue

挂起的时候对已经执行的处理没有影响

#### 3 dispatch_resume 继续执行quque

