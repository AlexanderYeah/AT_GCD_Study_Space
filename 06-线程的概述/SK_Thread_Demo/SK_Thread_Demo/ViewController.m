//
//  ViewController.m
//  SK_Thread_Demo
//
//  Created by TrimbleZhang on 2018/12/13.
//  Copyright © 2018 AlexanderYeah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    
    
    
    
    
    
    
}


@end
