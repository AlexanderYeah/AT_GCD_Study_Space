#### 1 dispatch_barrier_async 概念

栅栏方法，暂时的将一部操作做成一个同步操作，向一个栅栏一样的分开

dispatch_barrier_async函数的作用是在进程管理中起到一个栅栏的作用,它等待所有位于barrier函数之前的操作执行完毕后执行,并且在barrier函数执行之后,barrier函数之后的操作才会得到执行,该函数需要同dispatch_queue_create函数生成的concurrent Dispatch Queue队列一起使用 



#### 2 作用

1.实现高效率的数据库访问和文件访问

2.避免数据竞争



#### 3 注意点：

1. 队列一定不能是全局队列（dispatch_get_global_queue）
2. 使用自己创建的并发队列（dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);）
3. 函数必须为asyn

在前面的任务执行结束后它(栅栏函数)才执行，而且它后面的任务等它执行完成之后才会执行（它前面任务顺序不能控制，它后面的顺序也不能控制）



#### 4  使用 

* 不使用栅栏方法

```objective-c
#import "ViewController.h"

@interface ViewController ()
{
    dispatch_queue_t _queue;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
    [self read];
    [self read];
    [self write];
}
- (void)read{
    //
    dispatch_async(_queue, ^{
        sleep(1);
        NSLog(@"read");
    });
}
- (void)write
{
    dispatch_async(_queue, ^{
        sleep(1);
        NSLog(@"write");
    });
}

@end
    
// 并发队列异步执行 日志输出时间是一定的
2018-12-12 10:13:19.814352+0800 GCD_Dispatch_Barrier_Demo[3297:42890] read
2018-12-12 10:13:19.814375+0800 GCD_Dispatch_Barrier_Demo[3297:42891] read
2018-12-12 10:13:19.814367+0800 GCD_Dispatch_Barrier_Demo[3297:42892] write
    
    
    
```



* 使用栅栏方法，将异步操作暂时变成同步操作

```objective-c

@interface ViewController ()
{
    dispatch_queue_t _queue;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
    
    [self read];
    [self read];
    [self write];
}
- (void)read{
    //
    dispatch_async(_queue, ^{
        sleep(1);
        NSLog(@"read");
    });
}
- (void)write
{
    // 使用栅栏方法
    dispatch_barrier_async(_queue, ^{
        sleep(1);
        NSLog(@"write");
    });

}

// 日志输出 则write 输出时间延迟1秒执行
2018-12-12 10:16:25.164446+0800 GCD_Dispatch_Barrier_Demo[3372:45243] read
2018-12-12 10:16:25.164445+0800 GCD_Dispatch_Barrier_Demo[3372:45244] read
2018-12-12 10:16:26.168443+0800 GCD_Dispatch_Barrier_Demo[3372:45244] write

```





