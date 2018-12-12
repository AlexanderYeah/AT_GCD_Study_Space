//
//  ViewController.m
//  GCD_dispatch_after_demo
//
//  Created by TrimbleZhang on 2018/12/12.
//  Copyright © 2018 AlexanderYeah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self delay];
}

- (void)delay
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    // 延时5秒执行任务
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW,(int64_t)(5.0 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
        NSLog(@"我来延时了");
    });
    
}






@end
