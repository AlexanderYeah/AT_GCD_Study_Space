//
//  ViewController.m
//  GCD_Dispatch_Barrier_Demo
//
//  Created by TrimbleZhang on 2018/12/12.
//  Copyright © 2018 AlexanderYeah. All rights reserved.
//

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
    // 使用栅栏方法
    dispatch_barrier_async(_queue, ^{
        sleep(1);
        NSLog(@"write");
    });

}

@end

