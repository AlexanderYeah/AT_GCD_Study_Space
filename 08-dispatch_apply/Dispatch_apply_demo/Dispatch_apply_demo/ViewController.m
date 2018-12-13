//
//  ViewController.m
//  Dispatch_apply_demo
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
    
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 迭代数组
    NSLog(@"begin");
    NSArray *arr = @[@"apple",@"orange",@"watermelon",@"banana"];
    dispatch_apply(arr.count, queue, ^(size_t idx) {
        NSLog(@"idx-%@",arr[idx]);
    });
    NSLog(@"end");
    
    
    
    
    
    
}


@end
