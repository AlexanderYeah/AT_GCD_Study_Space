

**GCD 会主动的提供一个队列供开发者使用。**



### 主队列 系统提供的串行队列

是在主线程执行的队列，所以是串行的队列。任务一个个执行。

> dispatch_get_main_queue()



#### 全局队列 系统提供的并发队列

全局队列是所有应用程序都能够使用的并发队列，不需要手动的创建并发队列了。

> dispatch_get_global_queue

###### 分为四个优先级

|                             名称                             | 执行方式 |    备注    |
| :----------------------------------------------------------: | :------: | :--------: |
|                   dispatch_get_main_queue                    |   串行   | 主线程执行 |
| dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);  |   并发   |  优先级高  |
| dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); |   并发   |    默认    |
|  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);  |   并发   |     低     |
| dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0); |   并发   |  后台执行  |





####  dispatch_queue_create

dispatch_queue_create 创建生成的队列不管是串行的还是并行的，优先级和全局队列形同的默认的优先级

```objective-c
    // 创建一个串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("sk1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("sk2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue3 = dispatch_queue_create("sk3", DISPATCH_QUEUE_SERIAL);
    
    // 打印1 2 3 为一个统一的任务。一个任务被拆分成多个任务放到多个串行队列中去，但是执行顺序还是要保持和
    // 在一个串行队列中的一致效果。打印顺序为 1 2 3
    dispatch_async(queue1, ^{
        NSLog(@"Hello from queue1");
    });
   
    dispatch_async(queue2, ^{
        NSLog(@"Hello from queue2");
    });
    
    dispatch_async(queue3, ^{
        NSLog(@"Hello from queue3");
    });

// 打印顺序 因为不同的队列，任务都是并发执行，所以打印顺序是不一定的
2018-12-13 10:49:22.267722+0800 SK_Thread_Demo[4976:69000] Hello from queue3
2018-12-13 10:49:22.267722+0800 SK_Thread_Demo[4976:69002] Hello from queue1
2018-12-13 10:49:22.267722+0800 SK_Thread_Demo[4976:69001] Hello from queue2

```





####  dispatch_set_target_queue 使用队列优先级，让队列指定队列同步执行

```objective-c
    // 目标队列
    dispatch_queue_t targetQueue = dispatch_queue_create("target", DISPATCH_QUEUE_SERIAL);
    
    // 创建一个串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("sk1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("sk2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue3 = dispatch_queue_create("sk3", DISPATCH_QUEUE_SERIAL);
    
    // 打印1 2 3 为一个统一的任务。一个任务被拆分成多个任务放到多个串行队列中去，但是执行顺序还是要保持和 在一个串行队列中的一致效果。例如说 打印顺序为 1 2 3
    
    // 变更优先级
    // 追加到目标串行队列中 防止处理并行执行
    dispatch_set_target_queue(queue3, targetQueue);
    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_set_target_queue(queue2, targetQueue);
    
    dispatch_async(queue1, ^{
        sleep(1);
        NSLog(@"Hello from queue1");
    });
   
    dispatch_async(queue2, ^{
        sleep(1);
        NSLog(@"Hello from queue2");
    });

    dispatch_async(queue3, ^{
        sleep(1);
        NSLog(@"Hello from queue3");
    });
	
// 打印结果
2018-12-13 11:03:58.880544+0800 SK_Thread_Demo[5310:79080] Hello from queue1
2018-12-13 11:03:59.885092+0800 SK_Thread_Demo[5310:79080] Hello from queue2
2018-12-13 11:04:00.886197+0800 SK_Thread_Demo[5310:79080] Hello from queue3

```

