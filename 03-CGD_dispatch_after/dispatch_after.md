#### 1 dispatch_after 概念

在指定时间之后将任务追加到主队列中。严格来说，这个时间并不是绝对准确的，但想要大致延迟执行任务，dispatch_after函数是很有效的。

```objective-c
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    // 延时5秒执行任务
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW,(int64_t)(5.0 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        // 5 秒之后将任务追加到主线程
        NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
        NSLog(@"我来延时了");
    });
    
```



#### 2 iOS 中 延时执行任务的方式常见的有

* NSTimer

```objective-c
[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(doSomething) userInfo:nil repeats:NO];
```

* performSelector  afterDelay

  ```objective-c
  [self performSelector:@selector(doSomething) withObject:self afterDelay:0.5];
  ```

